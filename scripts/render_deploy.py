#!/usr/bin/env python3
"""Create or update the priceticker service on Render, from the command line.

The dashboard is convenient, but a deploy that only exists in a browser is a
deploy nobody can reproduce. This script uses Render's public API and the same
contract as `render.yaml`:

    python scripts/render_deploy.py --check   # is the tree deployable?
    python scripts/render_deploy.py --url-only
    python scripts/render_deploy.py --yes     # create/update and deploy
    python scripts/render_deploy.py --yes --replace-env

Credentials and runtime secrets are read from gitignored dotenv files:

    envs/.env.render     RENDER_API_KEY, RENDER_REPO, APP_KEY, APP_USER_*
    envs/.env.supabase   DATABASE_URL
    envs/.env.resend     RESEND_API_KEY, MAIL_FROM

Nothing here is committed. If APP_KEY or the admin password is missing, the
script generates it and writes it to `envs/.env.render` (mode 0600), so the next
deploy uses the same value.
"""

from __future__ import annotations

import argparse
import base64
import json
import os
import re
import secrets
import string
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
API = "https://api.render.com/v1"

SERVICE = {
    "name": "priceticker",
    "type": "web_service",
    "branch": "main",
    "healthCheckPath": "/up",
    "plan": "free",
    "region": "oregon",
}

# Create and PATCH put Docker settings under serviceDetails.envSpecificDetails
# (the API rejects a non-static service without serviceDetails). `env` is the
# deprecated alias for `runtime`; both are sent on create so older and newer
# API versions agree on the builder.
DOCKER_BUILD = {
    "env": "docker",
    "runtime": "docker",
    "envSpecificDetails": {
        "dockerContext": ".",
        "dockerfilePath": "./Dockerfile",
    },
}

BASE_ENV = {
    "APP_NAME": "PriceTicker",
    "APP_ENV": "production",
    "APP_DEBUG": "false",
    "APP_URL": "https://priceticker.onrender.com",
    "APP_TIMEZONE": "America/Sao_Paulo",
    "APP_LOCALE": "en",
    "APP_CURRENCY_LOCALE": "pt_BR",
    "APP_USER_NAME": "Admin",
    "DEFAULT_STORES_COUNTRY": "brazil",
    "DB_CONNECTION": "pgsql",
    "DB_SEARCH_PATH": "priceticker",
    "DB_SSLMODE": "require",
    "SESSION_DRIVER": "database",
    "SESSION_SECURE_COOKIE": "true",
    "CACHE_STORE": "database",
    "QUEUE_CONNECTION": "database",
    "LOG_CHANNEL": "stack",
    "LOG_STACK": "single",
    "LOG_LEVEL": "info",
    "TRUSTED_PROXIES": "*",
    "RUN_PRICE_CACHE_ON_BOOT": "0",
    "AFFILIATE_ENABLED": "false",
    "BROWSER_SCRAPER_ENABLED": "true",
    "SCRAPER_BASE_URL": "http://127.0.0.1:3000",
    "MAIL_MAILER": "resend",
    "MAIL_FROM_NAME": "PriceTicker",
}

REQUIRED = ["Dockerfile", ".dockerignore", "render.yaml", "composer.lock",
            "package-lock.json", "envs/.env.example", "routes/web.php",
            "docker/php/apache-vhost.conf", "docker/php/start-app.sh"]

MUST_REACH_IMAGE = ["app", "bootstrap", "config", "database", "docker",
                    "public", "resources", "routes", "vendor", "composer.lock"]


def env_pairs(path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    if not path.is_file():
        return values
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        name, _, value = line.partition("=")
        value = value.split(" #", 1)[0].strip()
        if name.strip() and value:
            values[name.strip()] = value
    return values


def write_env(path: Path, values: dict[str, str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("".join(f"{name}={value}\n" for name, value in values.items()),
                    encoding="utf-8")
    path.chmod(0o600)


def ensure_local_secrets() -> None:
    """Generate the two values that must be stable across deploys."""
    path = ROOT / "envs/.env.render"
    values = env_pairs(path)

    changed = False
    if not values.get("APP_KEY"):
        values["APP_KEY"] = "base64:" + base64.b64encode(os.urandom(32)).decode()
        changed = True
    if not values.get("APP_USER_EMAIL"):
        values["APP_USER_EMAIL"] = "admin@priceticker.local"
        changed = True
    if not values.get("APP_USER_PASSWORD"):
        alphabet = string.ascii_letters + string.digits
        values["APP_USER_PASSWORD"] = "".join(secrets.choice(alphabet)
                                              for _ in range(28))
        changed = True
    if changed:
        write_env(path, values)
        print(f"wrote generated secrets to {path.relative_to(ROOT)} (mode 0600)")


def read_key() -> str:
    candidates = [
        os.environ.get("RENDER_API_KEY", "").strip(),
        env_pairs(ROOT / "envs/.env.render").get("RENDER_API_KEY", ""),
    ]
    home = Path.home() / ".render_api_key"
    if home.is_file():
        candidates.append(home.read_text(encoding="utf-8").strip())
    for value in candidates:
        if value:
            return value
    raise SystemExit("no Render API key: set RENDER_API_KEY or add it to envs/.env.render")


def read_repo() -> str:
    try:
        result = subprocess.run(
            ["git", "-C", str(ROOT), "remote", "get-url", "origin"],
            capture_output=True, text=True, timeout=20,
        )
        remote = result.stdout.strip()
        if result.returncode == 0 and remote.startswith(("https://", "http://", "git@")):
            return remote.removesuffix(".git").replace(
                "git@github.com:", "https://github.com/")
    except (OSError, subprocess.SubprocessError):
        pass
    return (os.environ.get("RENDER_REPO", "").strip()
            or env_pairs(ROOT / "envs/.env.render").get("RENDER_REPO", ""))


def runtime_env() -> list[dict[str, str]]:
    values = dict(BASE_ENV)
    render = env_pairs(ROOT / "envs/.env.render")
    values.update({name: value for name, value in render.items()
                   if not name.startswith("RENDER_") and value})

    database = env_pairs(ROOT / "envs/.env.supabase").get("DATABASE_URL", "")
    if not database:
        raise SystemExit(
            "no DATABASE_URL: add it to envs/.env.supabase. Render's free plan has "
            "no persistent disk, so SQLite would lose every watch on redeploy.")
    values["DATABASE_URL"] = database

    mail = env_pairs(ROOT / "envs/.env.resend")
    if mail.get("RESEND_API_KEY"):
        values["RESEND_API_KEY"] = mail["RESEND_API_KEY"]
        values["MAIL_MAILER"] = "resend"
        if mail.get("MAIL_FROM"):
            values["MAIL_FROM_ADDRESS"] = mail["MAIL_FROM"]
    else:
        values["MAIL_MAILER"] = "log"
        values.pop("RESEND_API_KEY", None)

    return [{"key": name, "value": value} for name, value in values.items()]


def check_tree() -> int:
    problems: list[str] = []
    for name in REQUIRED:
        if not (ROOT / name).is_file():
            problems.append(f"missing {name}")

    ignore = ROOT / ".dockerignore"
    ignored = [line.strip().rstrip("/") for line in ignore.read_text().splitlines()
               if line.strip() and not line.startswith("#")] if ignore.is_file() else []
    for name in MUST_REACH_IMAGE:
        if name == "vendor":
            continue  # built inside the image
        if any(name == pattern or name.startswith(pattern + "/") for pattern in ignored):
            problems.append(f"{name} is excluded by .dockerignore but the image needs it")

    dockerfile = (ROOT / "Dockerfile").read_text(encoding="utf-8") \
        if (ROOT / "Dockerfile").is_file() else ""
    for needle in ("apache-vhost.conf", "npm ci", "pdo_pgsql"):
        if needle not in dockerfile:
            problems.append(f"Dockerfile is missing {needle}")

    if not (ROOT / "envs/.env.supabase").is_file():
        problems.append("missing envs/.env.supabase (DATABASE_URL)")
    if not (ROOT / "envs/.env.render").is_file():
        problems.append("missing envs/.env.render (RENDER_API_KEY / APP_KEY)")

    print(f"render preflight: {len(REQUIRED)} files checked, "
          f"{len(problems)} problem(s)")
    for problem in problems:
        print("FAIL:", problem)
    print("check: OK" if not problems else "check: FAILED")
    return 1 if problems else 0


class RenderError(RuntimeError):
    pass


def call(path: str, key: str, payload: dict | None = None,
         method: str = "GET") -> dict:
    request = urllib.request.Request(
        API + path,
        data=json.dumps(payload).encode() if payload is not None else None,
        method=method,
        headers={
            "Authorization": f"Bearer {key}",
            "Content-Type": "application/json",
            "Accept": "application/json",
        },
    )
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            body = response.read().decode("utf-8")
            return json.loads(body) if body else {}
    except urllib.error.HTTPError as error:
        detail = error.read().decode("utf-8", "replace")[:500]
        hint = ""
        if error.code in (401, 403):
            hint = " — check that the Render API key is valid and owns the service"
        raise RenderError(f"{error.code} {error.reason}{hint}\n  {detail}") from error
    except urllib.error.URLError as error:
        raise RenderError(f"cannot reach {API}: {error.reason}") from error
    except ValueError as error:
        raise RenderError(f"unreadable answer from {path}: {error}") from error


def entity(answer, *names: str) -> dict:
    if isinstance(answer, list):
        for item in answer:
            found = entity(item, *names)
            if found:
                return found
        return {}
    if not isinstance(answer, dict):
        return {}
    for name in names:
        found = answer.get(name)
        if isinstance(found, dict) and found:
            return found
    return answer if ("id" in answer or "name" in answer) else {}


def entities(answer, *names: str) -> list[dict]:
    items = answer if isinstance(answer, list) else [answer]
    out: list[dict] = []
    for item in items:
        if isinstance(item, list):
            out.extend(entities(item, *names))
            continue
        found = entity(item, *names)
        if found:
            out.append(found)
    return out


def cursor_of(answer) -> str:
    items = answer if isinstance(answer, list) else [answer]
    for item in items:
        if isinstance(item, dict) and item.get("cursor"):
            return item["cursor"]
    return ""


def find_service(key: str, repo: str) -> dict | None:
    cursor = None
    named: dict | None = None
    while True:
        page = call("/services?limit=100" + (f"&cursor={cursor}" if cursor else ""), key)
        for service in entities(page, "service"):
            if repo and (service.get("repo") or "").rstrip("/").lower() == \
                    repo.rstrip("/").lower():
                return service
            if service.get("name") == SERVICE["name"]:
                named = service
        cursor = cursor_of(page)
        if not cursor:
            return named if not repo else None


def find_owner(key: str) -> dict:
    owners = entities(call("/owners", key), "owner")
    if not owners:
        raise RenderError("this key cannot see any Render account")
    personal = [owner for owner in owners if owner.get("type") == "user"]
    return personal[0] if personal else owners[0]


def configure(service_id: str, key: str) -> dict:
    body = {
        "serviceDetails": {
            **DOCKER_BUILD,
            "healthCheckPath": SERVICE["healthCheckPath"],
        },
    }
    call(f"/services/{service_id}", key, body, "PATCH")
    return entity(call(f"/services/{service_id}", key), "service")


def get_env_vars(service_id: str, key: str) -> list[dict[str, str]]:
    # The endpoint defaults to 20 rows; without limit=100 a merge would drop
    # every dashboard variable past the first page.
    answer = call(f"/services/{service_id}/env-vars?limit=100", key)
    rows = answer.get("envVars") if isinstance(answer, dict) else answer
    out = []
    for row in rows or []:
        if not isinstance(row, dict):
            continue
        env = row.get("envVar") if isinstance(row.get("envVar"), dict) else row
        name = str(env.get("key") or "").strip()
        if name:
            out.append({"key": name, "value": env.get("value", "")})
    return out


def set_env_vars(service_id: str, key: str, rows: list[dict[str, str]]) -> None:
    call(f"/services/{service_id}/env-vars", key, rows, "PUT")


def merge_env_vars(current: list[dict[str, str]],
                   wanted: list[dict[str, str]]) -> list[dict[str, str]]:
    merged = {row["key"]: row.get("value", "") for row in current if row.get("key")}
    merged.update({row["key"]: row.get("value", "") for row in wanted if row.get("key")})
    return [{"key": name, "value": value} for name, value in merged.items()]


def create_service(key: str, repo: str, owner: dict) -> dict:
    body = {
        "type": SERVICE["type"],
        "name": SERVICE["name"],
        "ownerId": owner["id"],
        "repo": repo,
        "branch": SERVICE["branch"],
        "autoDeployTrigger": "commit",
        "serviceDetails": {
            **DOCKER_BUILD,
            "plan": SERVICE["plan"],
            "region": SERVICE["region"],
            "healthCheckPath": SERVICE["healthCheckPath"],
            "numInstances": 1,
        },
    }
    try:
        answer = call("/services", key, body, "POST")
    except RenderError as error:
        raise RenderError(
            f"{error}\n  The repository must be public or connected to this "
            "Render account, and the branch must exist.") from error

    # POST /services answers with {"service": {...}, "deployId": "..."}.
    service = entity(answer, "service")
    if not service.get("id"):
        raise RenderError(f"service created but the answer had no id: {answer}")
    return service


ANSI = re.compile(r"\x1b\[[0-9;]*[A-Za-z]")


def now() -> str:
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())


def build_log(service_id: str, key: str, since: str,
              owner_id: str = "", limit: int = 400) -> list[str]:
    if not owner_id:
        owners = entities(call("/owners", key), "owner")
        owner_id = owners[0]["id"] if owners else ""
    if not owner_id:
        return []
    path = (f"/logs?ownerId={owner_id}&startTime={since}&endTime={now()}"
            f"&limit={limit}&direction=forward&resource={service_id}")
    try:
        entries = call(path, key).get("logs", [])
    except RenderError:
        return []
    lines = []
    for entry in entries:
        text = ANSI.sub("", entry.get("message", "")).strip()
        if text:
            lines.append(text)
    return lines


def print_build_failure(service_id: str, key: str, since: str) -> None:
    lines = build_log(service_id, key, since)
    if not lines:
        print("build failed and Render returned no log; open the dashboard")
        return
    print("the build said:")
    for line in lines[-30:]:
        print("   ", line.encode("ascii", "replace").decode()[:220])


ACTIVE_DEPLOY_STATES = ("created", "pre_deploy_in_progress",
                        "build_in_progress", "update_in_progress")


def cancel_active_deploys(service_id: str, key: str) -> None:
    """Stop builds Render started before the environment was in place."""
    try:
        page = call(f"/services/{service_id}/deploys?limit=10", key)
    except RenderError:
        return
    for item in entities(page, "deploy"):
        if item.get("status") in ACTIVE_DEPLOY_STATES and item.get("id"):
            try:
                call(f"/services/{service_id}/deploys/{item['id']}/cancel",
                     key, None, "POST")
                print(f"canceled early deploy {item['id']}")
            except RenderError:
                pass


def deploy(service_id: str, key: str) -> str:
    # Follow the deployment returned by this request. Reading the newest one
    # after a failed POST could silently report an older live build as success.
    trigger = entity(call(f"/services/{service_id}/deploys", key,
                          {"clearCache": "do_not_clear"}, "POST"), "deploy")
    deploy_id = trigger.get("id")
    if not deploy_id:
        raise RenderError("Render accepted the deploy but returned no deployment id")
    print(f"deploy {deploy_id}: building…")

    seen = ""
    for _ in range(180):  # ~30 minutes at 10s
        time.sleep(10)
        status = entity(call(f"/services/{service_id}/deploys/{deploy_id}", key),
                        "deploy")
        state = f"{status.get('status')} {(status.get('commit') or {}).get('shortHash', '')}"
        if state != seen:
            print(" ", state)
            seen = state
        if status.get("status") in ("live", "build_failed", "update_failed",
                                    "canceled"):
            if status.get("status") != "live":
                print_build_failure(service_id, key, trigger.get("createdAt", ""))
            return status["status"]
    return "timeout"


def run(key: str, repo: str, force: bool, replace_env: bool) -> int:
    existing = find_service(key, repo)
    if existing and not force:
        url = existing.get("serviceDetails", {}).get("url")
        print(f"service {existing.get('name')} already exists: {url or '(no url yet)'}")
        print("re-run with --yes to deploy the current commit")
        return 0

    if check_tree():
        print("refusing to deploy a tree that fails preflight")
        return 1

    if existing:
        service = configure(existing["id"], key)
        print(f"reconfigured {existing.get('name')} -> docker runtime")
    else:
        owner = find_owner(key)
        print(f"owner:  {owner.get('name')} [{owner.get('id')}]")
        service = create_service(key, repo, owner)

    service_id = service["id"]
    wanted = runtime_env()
    if replace_env:
        set_env_vars(service_id, key, wanted)
        print(f"env:     replaced with {len(wanted)} variable(s)")
    else:
        # A failed read must never turn a merge into a destructive replacement.
        current = get_env_vars(service_id, key)
        merged = merge_env_vars(current, wanted)
        set_env_vars(service_id, key, merged)
        print(f"env:     {len(merged)} variable(s), "
              f"{max(0, len(merged) - len(wanted))} kept from the dashboard")

    print(f"service: {service.get('name')} [{service_id}]")
    print(f"url:     {service.get('serviceDetails', {}).get('url')}")
    cancel_active_deploys(service_id, key)
    outcome = deploy(service_id, key)
    print("deploy:", outcome)
    if outcome != "live":
        print("not live — see the build log above, or "
              f"{API}/services/{service_id}/deploys")
        return 1

    details = call(f"/services/{service_id}", key).get("serviceDetails", {})
    print("live:   ", details.get("url") or "(URL not reported yet)")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true",
                        help="only verify that the tree is deployable")
    parser.add_argument("--url-only", action="store_true",
                        help="print the existing service URL and exit")
    parser.add_argument("--yes", action="store_true",
                        help="deploy even if the service already exists")
    parser.add_argument("--replace-env", action="store_true",
                        help="replace the whole environment instead of merging")
    args = parser.parse_args()

    if args.check:
        return check_tree()

    ensure_local_secrets()
    key = read_key()
    repo = read_repo()
    if not repo:
        raise SystemExit("no repository: add git remote origin or RENDER_REPO")

    if args.url_only:
        service = find_service(key, repo)
        if not service:
            print("no service for", repo)
            return 1
        print(service.get("serviceDetails", {}).get("url") or "(no url yet)")
        return 0

    try:
        return run(key, repo, args.yes, args.replace_env)
    except RenderError as error:
        print("render error:", error)
        return 1
    except KeyboardInterrupt:
        print("interrupted; the deploy may still be running on Render")
        return 130


if __name__ == "__main__":
    sys.exit(main())
