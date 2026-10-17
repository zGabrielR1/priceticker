# Phase 0 — Recon: PriceBuddy fork for Brazilian deal intelligence

Date: 2026-10-17
Source: https://github.com/jez500/pricebuddy @ main (34f2b2f, release/oct-26)
Fork location: /home/pwdmcl/data/ppp/projects/priceticker

## 1. Stack

- **Backend**: Laravel 12, PHP 8.4, Filament 3 (admin UI), Sanctum (API tokens), MySQL 8.2.
- **Frontend**: Filament (Livewire/Blade) + Vite/Tailwind; VuePress docs; browser extension + CLI are separate repos.
- **Scraping**: `jez500/web-scraper-for-laravel` (DOM selectors/regex/xpath/json/schema_org) + optional SeleniumBase headless browser service (`jez500/seleniumbase-scrapper`). AI healing (OpenAI/Anthropic/Gemini/Ollama) optional.
- **Queue/scheduler**: Laravel Scheduler (`app/Console` commands `FetchAll`, `FetchDue`) + queue jobs (`UpdateAllPricesJob`, `UpdateProductPricesJob`); default cron `0 6 * * *` global, per-product intervals 5m..24h.
- **Notifications**: app (database), email, Pushover, Gotify, Apprise, Telegram, Discord, **ntfy** (already present). `NotificationHistoryResource` tracks sends.
- **API**: Sanctum token auth with abilities; Filament API Service exposes CRUD for products/stores/tags + meta-extraction + client-config; OpenAPI spec at `/docs/api`; ETag/304 on client-config.
- **Tests**: Pest/PHPUnit, 165 test files (Feature + Unit); requires MySQL (`DB_HOST=tests_db`); 512M memory. PHPStan + Pint for static analysis.
- **License**: GPL-3.0 WITH MODIFICATIONS — noncommercial use permitted; commercial distribution/hosted-for-profit prohibited. Flag for any monetization plan.

## 2. Data model (extension points)

- `Product` (tracked item) ↔ `Url` (listing pages) ↔ `Price` (history) ↔ `Store` (scrape strategy). `ProductSource` (search/category URL → top N). `Tag`, `User`, `Notification`, `UrlResearch`.
- Store scrape strategy: slots `title/price/image/availability` with types `schema_org|selector|xpath|regex|json`, plus locale/currency/cookies/scraper_service. Auto-store creation tries strategies.
- Price insights already compute percentile, deal score, distribution, drop events — reuse for deal engine.
- `ProductSource` already covers "CATEGORY (retailer category/search URL, top N)" partially.

## 3. Exact extension points

| Need | Where |
|---|---|
| New store adapters | `Store` records + scrape_strategy JSON; auto-create; optional `AutoCreateStore`. For official APIs (ML, Amazon), add a strategy type or a service class. |
| New tracking-target types | New Eloquent models + Filament resources + migrations; or generalize `Product`/`ProductSource` with a `type` enum (FAMILY, BRAND, COUPON). |
| Price-history queries | `Product::prices()` (HasManyThrough Price), `LowestPriceInDays` scope, insights cache. |
| Notifications | `app/Notifications/Channels/*` + `PriceAlertNotification`/`StockAlertNotification`. |
| API | `routes/api.php` + Filament API handlers/requests/transformers under `app/Filament/Resources/*/Api`. |
| Scheduler | `ScheduleHelper::registerSchedule`. |

## 4. Scraping mechanism detail

- HTTP (curl) default; browser (SeleniumBase) for JS. Cache TTL via settings. Soft-404 guards. Missing-price-as-out-of-stock opt-in. AI healing + self-heal. Rate limiting/backoff/CAPTCHA detection are NOT present — must add.

## 5. Fork strategy (upstream-merge friendly)

- Keep `origin` pointing at upstream; add no edits to vendor/core where avoidable.
- Create branch `brazil-deal-intel` (or `main` fork). Prefer additive changes: new models/resources/migrations, new `app/Services/Adapters/*`, seed JSON for BR stores, new config files. Avoid renaming core tables.
- Vendor foundry modules (envfile, mail, turnstile, deploy) into `app/Foundry/` or `app/Services/Foundry/` only if needed; prefer Python-side reuse via separate deploy repo? Note: PriceBuddy is PHP; foundry is Python/stdlib. Bridging requires either reimplementing foundry's contracts in PHP or keeping foundry for deploy-only. Decision needed.
- Track upstream with `git fetch upstream`; merge `release/*` tags. Keep BR changes in isolated directories to minimize conflicts.

## 6. Constraints & risks

- No PHP runtime in this dev environment (no php, mysql, docker) → cannot run Pest/PHPStan locally. Verification relies on CI or Docker. Foundry Python tests (57) run locally.
- License prohibits commercial use; personal self-hosted OK.
- Official APIs preferred (ML has official API; Amazon PA-API; Shopee open platform) over scraping; scraping BR retailers risks blocks/CAPTCHA — quarantine needed.
- Brazilian price formatting (R$ 1.234,56) must be parsed; Money library present.

## 7. User pivot (2026-10-17)

- Oracle Cloud Always Free unavailable → use fallback deploy targets. Foundry provides Render/Fly/Vercel templates (`templates/deploy/{render,fly,vercel}`) with `{{TOKENS}}` and `python -m foundry.deploy`. Vercel template explicitly supports storefront-only + proxy to backend (good for "deploy front end as soon as possible").
- Prioritize deploying a frontend early. Candidate: Vercel-hosted Next.js/Flutter-web storefront proxying to a Render/Fly backend; or ship PriceBuddy's Filament UI via Render/Fly docker image.
- Reuse foundry ideas: stdlib-only core where new code is Python, frozen dataclasses with validation, config via env in one `resolve_*`, fail-safe when unconfigured, vendor + drift check, deploy templates.

## 8. Proposed adapted roadmap (approval requested)

Given no local PHP test runtime, recommend phasing work so each slice is verifiable:

- **Phase 0 (done)**: this recon.
- **Phase 1 (next)**: Add a `Watch` abstraction as a new model + Filament resource + migration + tests, keeping Product/ProductSource intact. Types: PRODUCT, FAMILY, CATEGORY, BRAND, COUPON. Rules: max price, % below 30/90-day median, record-low, store allowlist, channels, cooldown. Plus a Python-side deal engine prototype (unit-tested, explainable) that consumes exported price history — leveraging foundry's stdlib-only/testing discipline.
- **Phase 2**: BR store seed configs (KaBuM, Pichau, Terabyte) as Store JSON + parser tests on saved HTML/JSON fixtures; ML official API adapter; rate limiting/backoff/quarantine in a new service.
- **Phase 3**: Discovery ingestion (Pelando/Promobit RSS) as a Python worker pushing to the API.
- **Phase 4**: Deal engine (percentile, record-low, fake-discount, coupon/shipping-adjusted, confidence, dedup/cooldown).
- **Phase 5**: Versioned REST API additions + FCM push (keep ntfy).
- **Phase 6**: Flutter Android app.
- **Phase 7**: Deploy via foundry templates (Render/Fly backend + Vercel frontend), backups, healthchecks, runbook. Defer Oracle Cloud.

## 9. Open questions for approval

1. Keep PriceBuddy (Laravel/PHP) as the core, or extract a Python backend using foundry/operator patterns? (Recommendation: keep Laravel for now; add Python workers for scraping/discovery that push via API, matching foundry's split-scraper idea in original Phase 7.)
2. Scope of "front end as soon as possible": deploy existing Filament UI to Render/Fly, or build a new Vercel storefront that proxies to backend? (Recommendation: Render/Fly docker image first — fastest, reuses upstream; Vercel storefront later.)
3. License: any commercial intent? If yes, the GPL-3.0-with-modifications terms need legal review before distribution.
4. Brazilian price parsing: parse in PHP (Money) or normalize in Python workers before pushing? (Recommendation: parse in PHP at ingest for consistency with existing insights.)
5. Should I create AGENTS.md/PROGRESS.md/CURRENTTASK in priceticker for state tracking (foundry-style), or keep meta in chat? (Recommendation: create them, prefixed to avoid upstream conflicts.)
6. Approval to proceed to Phase 1? Or adjust scope first?
