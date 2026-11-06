"""Regression tests for deployment secrets and environment preservation."""
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import render_deploy as deploy


class DeploymentTest(unittest.TestCase):
    def test_environment_reads_every_page_using_last_cursor(self):
        pages = [
            [{"envVar": {"key": "A", "value": "1"}, "cursor": "first"},
             {"envVar": {"key": "B", "value": "2"}, "cursor": "last"}],
            [{"envVar": {"key": "C", "value": "3"}, "cursor": "next"}],
            [],
        ]
        with patch.object(deploy, "call", side_effect=pages) as api:
            self.assertEqual(deploy.get_env_vars("service", "key"),
                             [{"key": "A", "value": "1"},
                              {"key": "B", "value": "2"},
                              {"key": "C", "value": "3"}])
            self.assertTrue(api.call_args_list[1].args[0].endswith("cursor=last"))

    def test_environment_rejects_malformed_or_repeating_pages(self):
        for pages in [[{}], [[{"key": "SECRET"}]],
                      [[{"envVar": {"key": "A", "value": "1"}, "cursor": "same"}]] * 2]:
            with self.subTest(pages=pages), patch.object(deploy, "call", side_effect=pages):
                with self.assertRaises(deploy.RenderError):
                    deploy.get_env_vars("service", "key")

    def test_relocated_secrets_keep_application_key(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "envs").mkdir()
            path = root / "envs/.env.render"
            path.write_text("APP_KEY=existing-key\nAPP_USER_EMAIL=admin@example.com\n"
                            "APP_USER_PASSWORD=existing-password\nRENDER_API_KEY=token\n")
            (root / "envs/.env.supabase").write_text("DATABASE_URL=postgres://example/db\n")
            with patch.object(deploy, "ROOT", root):
                deploy.ensure_local_secrets()
                values = {row["key"]: row["value"] for row in deploy.runtime_env()}
                self.assertEqual(values["APP_KEY"], "existing-key")
                self.assertEqual(values["DATABASE_URL"], "postgres://example/db")
                self.assertNotIn("RENDER_API_KEY", values)
                self.assertFalse((root / ".env.render").exists())

    def test_failed_environment_read_never_replaces_secrets(self):
        with patch.object(deploy, "find_service", return_value={"id": "service", "name": "test"}), \
                patch.object(deploy, "check_tree", return_value=0), \
                patch.object(deploy, "configure", return_value={"id": "service"}), \
                patch.object(deploy, "runtime_env", return_value=[]), \
                patch.object(deploy, "get_env_vars", side_effect=deploy.RenderError("unavailable")), \
                patch.object(deploy, "set_env_vars") as write:
            with self.assertRaises(deploy.RenderError):
                deploy.run("key", "repo", True, False)
            write.assert_not_called()

    def test_failed_deploy_request_never_adopts_an_old_live_deploy(self):
        with patch.object(deploy, "call", side_effect=deploy.RenderError("rejected")) as api:
            with self.assertRaises(deploy.RenderError):
                deploy.deploy("service", "key")
            self.assertEqual(api.call_count, 1)

    def test_deploy_tracks_the_id_returned_by_create(self):
        for created in [{"id": "new-deploy"}, {"deploy": {"id": "new-deploy"}}]:
            with self.subTest(created=created), \
                    patch.object(deploy, "call", side_effect=[created, {"id": "new-deploy", "status": "live"}]) as api, \
                    patch.object(deploy.time, "sleep"):
                self.assertEqual(deploy.deploy("service", "key"), "live")
                self.assertEqual(api.call_args.args[0], "/services/service/deploys/new-deploy")

    def test_missing_deploy_id_fails_instead_of_reporting_success(self):
        with patch.object(deploy, "call", return_value={}) as api:
            with self.assertRaises(deploy.RenderError):
                deploy.deploy("service", "key")
            self.assertEqual(api.call_count, 1)

    def test_merge_preserves_dashboard_only_values(self):
        result = deploy.merge_env_vars(
            [{"key": "SECRET", "value": "keep"}, {"key": "APP_NAME", "value": "old"}],
            [{"key": "APP_NAME", "value": "PriceTicker"}])
        self.assertEqual({row["key"]: row["value"] for row in result},
                         {"SECRET": "keep", "APP_NAME": "PriceTicker"})


if __name__ == "__main__":
    unittest.main()


class AlwaysOnPlanTest(unittest.TestCase):
    def test_reconfigure_preserves_existing_compute_plan(self):
        with patch.object(deploy, "call", return_value={"id": "srv-test"}) as call:
            deploy.configure("srv-test", "test-key")
        patch_body = call.call_args_list[0].args[2]
        self.assertNotIn("plan", patch_body["serviceDetails"])
        self.assertEqual("false", deploy.BASE_ENV["AFFILIATE_ENABLED"])
