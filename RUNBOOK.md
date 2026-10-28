# Runbook — priceticker (Brazilian deal intelligence)

## Local development
- PHP 8.4 + MySQL 8.2 (podman): see Phase 0/1 verification commands in PROGRESS.md.
- `cp envs/.env.example-dev .env && php artisan key:generate`
- `php artisan migrate --force && php artisan buddy:create-stores brazil`
- `npm install && npm run build`
- `php artisan serve` (or `docker compose up`)

## Tests
- PHP: `vendor/bin/pest` (requires MySQL `tests_db`), `vendor/bin/phpstan analyse`, `vendor/bin/pint`.
- Python: `cd tools && python -m unittest discover br_deals/tests -v`.
- Full PHP suite has been green on PHP 8.4 / MySQL 8.2 (1 skipped); the mobile
  API routes are covered by `RoutePermissionsTest` (every Sanctum route must
  carry an `ability:` middleware).

## Deploy on Render (current production path)

The service is built by Render from this repository's `Dockerfile`; nothing is
built on the laptop. State lives in Supabase Postgres, so the free plan's
ephemeral disk does not lose watches or price history.

### One-time setup
1. Create the database schema (only once):
   ```sql
   create schema if not exists priceticker;
   ```
   The app also does this on first boot when the connection user may create
   schemas. `DB_SEARCH_PATH=priceticker` keeps its tables out of the shared
   project's `public` schema.
2. Copy the deploy credentials into gitignored files:
   - `envs/.env.render`: `RENDER_API_KEY`, `APP_KEY`, `APP_USER_EMAIL`,
     `APP_USER_PASSWORD`
   - `envs/.env.supabase`: `DATABASE_URL` (Supabase **session pooler**, port 5432)
   - `envs/.env.resend`: `RESEND_API_KEY`, `MAIL_FROM`
   Generate `APP_KEY` once and keep it forever: changing it invalidates
   sessions and encrypted values. The deploy script generates a missing key
   and admin password into `envs/.env.render` (mode 0600).
3. Deploy:
   ```shell
   python scripts/render_deploy.py --check
   python scripts/render_deploy.py --yes
   ```
   Live URL: <https://priceticker.onrender.com>. Admin: `/admin`, with the
   email/password from `envs/.env.render`.

### Every later deploy
```shell
python scripts/render_deploy.py --yes
```
The script merges the service environment by default (dashboard-only values
survive); `--replace-env` is the deliberate reset. It triggers a deploy, watches
it to `live`, and prints the build log if the build fails. A push to `main`
also triggers a build when the repository is connected to Render; when it does
not, the script is the reliable path and deploys the current branch head.

### Operating notes
- Health check: `/up` (app-only; it does not fail when Postgres has a blip).
- One instance only: Apache, the scheduler and the queue worker share one container, so
  two instances would run the scheduler twice.
- First boot creates the schema, applies regular **and** settings migrations,
  creates the Brazilian stores and the admin user. Later boots only apply new
  migrations; the admin is never re-seeded over an existing account.
- `.github/workflows/uptime.yml` checks `/up` and `/admin/login` every five
  minutes using free GitHub Actions minutes for this public repository. This
  keeps Render active under normal operation and detects database-backed login
  failures. Failed runs appear in Actions and GitHub's notification system.
  Render grants 750 instance hours per workspace/month; one service uses at
  most 744 hours, so other free services sharing that workspace reduce coverage.
  GitHub schedules can be delayed or dropped and are disabled after 60 days
  without repository activity. This is best-effort continuous operation, not
  guaranteed uptime. Check the workflow remains enabled during maintenance.
- Supervisor runs `schedule:work` and the queue worker with the platform's
  environment. Debian cron clears injected variables and should not be used
  for this hosted build.
- `APP_KEY`, `DATABASE_URL` and the admin password are Render secrets; they are
  never in `render.yaml` (which uses `sync: false` placeholders).
- The entrypoint honours Render's `$PORT`; do not hard-code 8080 in the
  dashboard. The image defaults to 8080 only when `PORT` is absent.
- The image runs `php artisan optimize` at boot. Route caching works because
  the root route is a controller, not a closure.
- Render logs include Apache access/error output and the Laravel `stderr`
  channel; `docker/php/start-app.sh` deliberately does not print the
  environment.

## Deploy fallback: Fly.io
- `fly launch --copy-config --now` (uses `fly.toml`, region gru); create volume
  `fly volumes create data`; set secrets via `fly secrets set`.
- Fly keeps `/data` on a volume; the app itself is stateless now, so the volume
  is only useful for local storage/uploads.

## Web (Flutter)
- Live demo: https://zgabrielr1.github.io/priceticker/
- Rebuild with backend URL: `flutter build web --dart-define=API_BASE_URL=https://priceticker.onrender.com`
- APK release: https://github.com/zGabrielR1/priceticker/releases/tag/v0.1.0

## Backups
- Postgres: use Supabase's scheduled backups (or `pg_dump` the `priceticker`
  schema). The database is the only durable state.
- Uploaded media lives in `storage/app/public` inside the container and is
  ephemeral on Render's free plan; use object storage before relying on uploads.

## Notes
- Python adapters/sinks live in `tools/br_deals/` and push to `/api/v1/*` once
  wired (HttpSink fail-safe until then).
- ntfy remains a notification channel; FCM is used for mobile push.
- Mail uses Resend when `RESEND_API_KEY` is present; otherwise Laravel's `log`
  mailer keeps the app usable without credentials.

## Browser scraping in the free hosted container

The Compose hostname `scraper` does not exist on Render. The hosted Dockerfile
installs Chromium and Supervisor starts a browser API on `127.0.0.1:3000`;
`SCRAPER_BASE_URL` points there. It is never exposed as a public endpoint.
The PHP server serializes rendering, browser sessions have isolated temporary
profiles, and Apache concurrency is bounded to leave memory for one browser.
The local renderer supports full-page HTML, bounded timeouts and a short JavaScript
wait. Advanced external-scraper options such as custom cookies/device emulation
require an external compatible scraper configured in `envs/.env.render`.

Set `BROWSER_SCRAPER_ENABLED=false` for a deployment without Chromium; stores
configured for browser scraping then use HTTP. HTTP cannot render JavaScript or
solve a retailer rejecting the hosting network. Extraction responses include
sanitized `errors` with a message and status code; failed HTTP responses are
never cached as product pages. Retailer blocks must never become price history.
