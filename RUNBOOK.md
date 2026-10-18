# Runbook — priceticker (Brazilian deal intelligence)

## Local development
- PHP 8.4 + MySQL 8.2 (podman): see Phase 0/1 verification commands in PROGRESS.md.
- `cp .env.example .env && php artisan key:generate`
- `php artisan migrate --force && php artisan buddy:create-stores brazil`
- `npm install && npm run build`
- `php artisan serve` (or docker compose up)

## Tests
- PHP: `vendor/bin/pest` (requires MySQL `tests_db`), `vendor/bin/phpstan analyse`, `vendor/bin/pint`.
- Python: `cd tools && python -m unittest discover br_deals/tests -v`.

## Deploy (fallback: Render / Fly.io)
- Build: `podman build -t priceticker-app:dev -f Dockerfile .` (verified green).
- Render: push repo; Render builds from `Dockerfile`; set env vars (DB_*, APP_KEY, FCM_SERVER_KEY, etc.) in dashboard; health check `/up`.
- Fly: `fly launch --copy-config --now` (uses `fly.toml`, region gru); create volume `fly volumes create data`; set secrets via `fly secrets set`.
- Oracle Cloud Always Free: deferred (not working yet).

## Web (Flutter)
- Live demo: https://zgabrielr1.github.io/priceticker/
- Rebuild with backend URL: `flutter build web --dart-define=API_BASE_URL=https://your-backend.example.com`
- APK release: https://github.com/zGabrielR1/priceticker/releases/tag/v0.1.0

## Backups
- MySQL: `mysqldump` daily (cron). Store media in `storage/app/public` — back up the volume.
- On Fly, snapshot the `data` volume.

## Notes
- Python adapters/sinks live in `tools/br_deals/` and push to `/api/v1/*` once wired (HttpSink fail-safe until then).
- ntfy remains a notification channel; FCM added for mobile push.