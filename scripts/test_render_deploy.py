"""Regression tests for deployment secrets and environment preservation."""
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import render_deploy as deploy


class DeploymentTest(unittest.TestCase):
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

    def test_merge_preserves_dashboard_only_values(self):
        result = deploy.merge_env_vars(
            [{"key": "SECRET", "value": "keep"}, {"key": "APP_NAME", "value": "old"}],
            [{"key": "APP_NAME", "value": "PriceTicker"}])
        self.assertEqual({row["key"]: row["value"] for row in result},
                         {"SECRET": "keep", "APP_NAME": "PriceTicker"})


if __name__ == "__main__":
    unittest.main()
