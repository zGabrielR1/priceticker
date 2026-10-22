# priceticker — progress

## Phase 0 — Recon (done)
- Cloned PriceBuddy (main, 34f2b2f). Added `upstream` remote.
- Wrote `RECON.md` (stack, DB, scraping, scheduler, notifications, API, license, tests, extension points, fork strategy).
- Decisions: keep Laravel; Render/Fly docker first; PHP price parsing at ingest; create state files.

## Phase 1 — Domain model (verified)
- Added `WatchType` enum (PRODUCT/FAMILY/CATEGORY/BRAND/COUPON) with labels/descriptions.
- Migration `2026_10_17_000000_create_watches_table.php` (user_id, type, name, config JSON, rules JSON, is_active, last_alerted_at, indexes).
- `App\Models\Watch` with casts, scopes (active, ofType, currentUser), rule/config helpers, cooldown check.
- `App\Filament\Resources\WatchResource` + List/Create/Edit pages (auto-discovered).
- `Database\Factories\WatchFactory`.
- `tests/Feature/Filament/WatchResourceTest.php` (index/create/all-types/helper/cooldown).

Verification: podman PHP 8.4 + MySQL 8.2 container. `pest --filter WatchResourceTest` → 6 passed (32 assertions). `phpstan` (level 5) → no errors. `pint` → clean.

## Phase 2 — Retailer adapters (verified slice)
- Store seed `database/seeders/Stores/brazil.php`: KaBuM, Pichau, Terabyte, Mercado Livre, Amazon BR, Magalu, Shopee (schema_org-first, pt_BR/BRL locale). Verified via `buddy:create-stores brazil` (7 created).
- `App\Services\Helpers\BrazilianPrice` BRL parser + unit test (10 cases, all pass).
- Python package `tools/br_deals/` (stdlib only, foundry-style): models, price parser, HTML helpers, JsonLd adapters for KaBuM/Pichau/Terabyte, per-domain rate limiter + backoff + CAPTCHA/block detection + quarantine, deal engine (percentile, record-low, fake-discount, coupon/shipping-adjusted, confidence, explainable).
- Fixtures + 15 unittests (all pass).

Verification: `cd tools && python -m unittest discover br_deals/tests` → 15 passed. `pest --filter BrazilianPriceTest` → 10 passed. `phpstan`/`pint` clean on new PHP.

## Phase 3 — Discovery ingestion (verified)
- `tools/br_deals/ingestion.py`: RSS fetch, dedupe by canonical URL, store identification, discount validation vs price history, Watch matching (keywords + store allowlist).
- `tools/br_deals/sinks.py`: InMemorySink + HttpSink (stdlib urllib, fail-safe when unconfigured, injectable transport).
- `Pipeline` orchestrates extract→dedupe→identify→validate→match→sink.
- 6 new unittests (all pass). Total Python: 21 passed.

Verification: `cd tools && python -m unittest discover br_deals/tests` → 21 passed.

## Phase 5 — Mobile API (verified)
- Migration `2026_10_18_000000_create_devices_table.php` + `App\Models\Device`.
- `App\Services\FcmService` (FCM push, fail-safe, injectable transport) + config/services.php fcm entry.
- Controllers under `app/Http/Controllers/Api/V1`: AuthController (token issue/revoke), WatchController (CRUD), DeviceController, PriceHistoryController, AlertController.
- Routes in `routes/api.php` under `/api/v1` (Sanctum).
- `tests/Feature/Api/V1/MobileApiTest.php` (7 tests) + `tests/Unit/FcmServiceTest.php` (4 tests).
- OpenAPI via existing Scramble (routes auto-discovered).

Verification: `pest --filter 'MobileApiTest|FcmServiceTest'` → 11 passed. `phpstan` (level 5) clean. `pint` clean.

## Phase 7 (partial) — Deploy
- Root `Dockerfile` (php:8.4-apache, builds frontend, runs on 8080) — builds successfully; `/up` returns 200.
- `render.yaml` and `fly.toml` generated via foundry.deploy (region gru for Fly).
- Deploy runbook: see `RUNBOOK.md`.

## Phase 6 — Flutter Android app (verified)
- Scaffolded `mobile/` (Flutter 3.47, Android). Clean architecture: core/data/domain/presentation.
- Screens: Login, Watch list/create (type picker), Product detail (fl_chart price chart), Alert inbox.
- ApiClient + repositories + providers (ChangeNotifier). FCM init guarded (needs google-services.json).
- `flutter analyze` → no issues; `flutter test` → 1 passed; `flutter build apk --debug` → APK built successfully.
- OpenAPI spec exported (`api.json` via `scramble:export`); generation script `tools/generate_client.sh`.
- Generated dart-dio client (`mobile/packages/priceticker_api`) cleaned up and verified (analyze clean, pub get, APK build).

## Phase 7 — Render deployment (live)
- Service `srv-dbcllqqvcj2c73f2rklg` (Oregon, free plan, Docker) builds from `main` and is live at <https://priceticker.onrender.com>.
- State: Supabase Postgres, dedicated `priceticker` schema (`DATABASE_URL` + `DB_SEARCH_PATH`), not the shared `public` schema.
- Verified after first boot: `/up` 200, `/` 302 to `/admin`, `/admin/login` 200, API token login 200, `/api/user` 200, `/api/v1/watches` 200.
- Verified schema: 23 tables, 39 migrations, 7 Brazilian stores, 1 admin, 10 settings rows.
- Runtime: Apache on Render's `$PORT`, cron + queue worker under supervisor; entrypoint creates the schema, migrates, applies settings migrations and warms caches.
- Deploy tooling: `scripts/render_deploy.py` now unwraps Render's `{"service": …}` create response, cancels superseded builds, and keeps all 29 env vars. First-boot logs no longer print the admin password.
