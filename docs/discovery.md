# Direct discovery and Android 1.1

## Recommendation

Current user decision: keep hosting free and accept best-effort availability.
The active blueprint remains Free; the paid alternative is reference-only.

For a future continuous-service requirement, keep durable Postgres and run the
scheduler on compute that does not sleep.
Prefer bounded retailer JSON catalogs or an authorized merchant feed; adapt them
into normalized offer events. Use public webhooks where a supplier actually
provides them. Otherwise poll a small keyword/category slice every five minutes,
with exponential backoff, rather than rendering whole product pages. Evaluate
watch rules locally and retain a personalized inbox. The existing HTML/browser
scraper remains useful for explicitly watched products that lack a catalog API.

This reaches the retailer without a Telegram publisher's editorial delay or
redirect links. It does not guarantee access to unpublished coupons, instant
updates, stock at checkout, or a single API across all Brazilian retailers.
There is no verified universal, non-affiliate, real-time Brazilian deals feed
in this implementation. Live source activation still needs a tested retailer
endpoint or a producer you control. No unverified retailer is enabled by default.

## Persistence and always-on hosting

The existing Render blueprint already uses external Supabase Postgres, including
sessions, cache and queue. Ephemeral Render storage is **not** the database.
Check the deployed DATABASE_URL/DB_SEARCH_PATH and actual DB reachability before
interpreting missing records as data loss. Do not rotate APP_KEY or point a
redeploy at a fresh database. Local files/logs/images still need object storage
if they must survive a redeploy; this discovery feature stores no local assets.

Render free compute sleeps after inactivity, interrupting both schedule:work
and queue:work. GitHub uptime checks are best effort, not continuous compute.
`render.always-on.yaml` prepares the same single-instance app on Starter with
external Postgres. Applying it changes billing; it has **not** been applied.
After a manual compute upgrade, the deploy script preserves the existing plan
instead of resetting it to Free. New services still default to Free.
The app already supervises scheduler and queue, so a second worker would duplicate
work unless scheduling is split deliberately. The smallest paid instance is a
starting configuration, not a capacity guarantee when Chromium also runs.

Alternative: deploy the existing Docker app on an always-on VPS with managed
Postgres, or a persistent Postgres volume plus off-host backups. This removes
Render sleep but adds OS/security/backup maintenance. Merely moving to another
free sleeping host does not solve continuous checks. A managed DB that can pause
also cannot provide an always-on guarantee; Supabase paid plans avoid inactivity
pauses. Choose paid managed compute + durable Postgres for the least migration
and operating work. A VPS is the control/cost alternative.

Before cutover: take a database backup, preserve APP_KEY, verify existing watch
and history counts, deploy migrations, run one discovery check, restart the
service, and verify those counts and inbox entries again. No production
credentials, database, billing, or service configuration were changed here.

## Source choices

| Source | Benefit | Boundary |
| --- | --- | --- |
| Retailer's public JSON catalog (VTEX adapter included) | Structured SKU/seller/stock/price; direct retailer product paths | Poll bounded slices; actual store support and access must be verified |
| Authorized merchant/marketplace API | Stable identities; some change notifications | Credentials/permissions required; notifications are not an unrestricted market-wide firehose |
| Your existing automation | Signed push; no scraping or network fetch in the receiver | Producer must emit current BRL price, stock, SKU/seller and a clean catalog path |
| Telegram/community channels | Broad editorial coverage | Late, affiliate-heavy, conditional/expired coupons; not enabled by default |
| HTML + headless browser | Broad fallback for a selected URL | Higher resource use and fragile markup |

VTEX catalog APIs are documented, but not every VTEX store exposes the same
endpoint or product slice. KaBuM/Pichau/Terabyte should **not** be assumed to
support this adapter. Mercado Livre notifications operate in an authorized
application/user context; they do not grant a public stream of every competing
seller's prices. Telegram channels are not a reliable upstream merchant feed.

References checked on 2026-10-28:
- https://render.com/docs/free
- https://render.com/docs/background-workers
- https://render.com/docs/disks
- https://supabase.com/docs/guides/platform/free-project-pausing
- https://developers.vtex.com/docs/api-reference/search-api
- https://developers.vtex.com/docs/guides/consult-product-search-information
- https://developers.mercadolivre.com.br/en_us/visits-resource/products-receive-notifications

## Configure a source

Operator configuration is deliberate: a mobile client cannot make the server
fetch arbitrary URLs. Set DISCOVERY_SOURCES to a JSON object (and rebuild Laravel
config cache/restart after changing environment variables):

```json
{
  "my-store": {
    "name": "My retailer",
    "driver": "vtex",
    "origin": "https://RETAILER-HOST",
    "endpoint": "https://RETAILER-HOST/api/catalog_system/pub/products/search?ft=rtx&_from=0&_to=49",
    "interval_seconds": 300
  },
  "my-automation": {
    "name": "My automated feed",
    "driver": "json",
    "origin": "https://RETAILER-HOST"
  }
}
```

Replace placeholders with a retailer you have verified. Separate each retailer
into its own source. A JSON source can also have a polling endpoint returning the
normalized payload below. No endpoint means push-only. Source IDs are the values
used by `rules.store_allowlist`, not a retailer display name or affiliate domain.

`python scripts/probe_discovery_sources.py` re-checks each candidate's bounded,
per-category slice (a fixed 10-product page; the search term is per-candidate)
behind a no-redirect, 5 MB-capped fetch and writes `source-probe/verified-sources.json`.
Every verified snapshot must then clear `php scripts/verify_snapshots_via_php_adapter.php`,
which runs it through the real `CatalogAdapter` (path regex, `..`/`%`/`//` rejections,
origin contract, positive-price-for-available rule) — passing the shape check
alone is not sufficient. Live 2026-11-02 (network-enabled machine, using the
app's own `User-Agent`):

| Candidate | Category | Outcome |
| --- | --- | --- |
| Ibyte `https://www.ibyte.com.br` | Electronics (GPUs) | **Verified** — 10/10 in-stock priced VTEX offers; `CatalogAdapter` 10 rows |
| Multilaser `https://www.multilaser.com.br` | Electronics (audio) | **Verified** — 10/10 in-stock priced offers; `CatalogAdapter` 10 rows |
| Hering `https://www.hering.com.br` | Apparel (menswear basics) | **Verified** — 46 in-stock priced offers; `CatalogAdapter` 54 rows |
| Farm `https://www.farmrio.com.br` | Apparel (women/beachwear) | **Verified** — 11 in-stock priced offers; `CatalogAdapter` 58 rows |
| Puket `https://www.puket.com.br` | Apparel (socks/hosiery) | **Verified** — 25 in-stock priced offers; `CatalogAdapter` 33 rows |
| Olympikus `https://www.olympikus.com.br` | Footwear (sneakers) | **Verified** — 96 in-stock priced offers; `CatalogAdapter` 110 rows |
| Karsten `https://www.karsten.com.br` | Home (bath/textiles) | **Verified** — 10/10 in-stock priced offers; `CatalogAdapter` 10 rows |
| Carrefour | Electronics | Blocked — HTTP 403 even with the product agent; not enabled |
| Fast Shop | Electronics | HTTP 503 at time of probe; unproven |
| Nagem | Electronics | HTTP 404 — does not expose this public catalog route |
| Drogasil | Pharmacy | Blocked — HTTP 403; pharmacy category not enabled by this build |
| Centauro | Sports | Blocked — HTTP 403; sports footwear covered via Olympikus instead |
| Havaianas / Arezzo / Tok&Stok / Cacau Show | (various) | HTTP 404 on the standard VTEX route; hostname not published as a bounded public catalog search |
| Azaleia | Footwear | Route returns HTML (Oracle CC storefront), not VTEX JSON; skipped |

Live end-to-end poll on 2026-11-02 against the expanded list: `php artisan
discovery:poll` fetched all seven sources concurrently and reported
`ibyte-gpu 10, hering-apparel 54, olympikus-footwear 110, farm-apparel 58,
puket-hosiery 33, karsten-home 10, multilaser-electronics 10` — 285 rows total,
every one normalized by the real PHP `CatalogAdapter` before write. This proves
the discovery pipeline is genuinely multi-retailer across electronics, apparel,
hosiery, footwear and home categories, not just the single-source demo from
earlier on 2026-11-02.

Verified retailers span categories; enabling one for a GPU radar is an operator
choice, not automatic. Several large BR retailers deliberately return 403 to any
automated catalog fetch — those stay disabled, which is the intended behaviour.

`scripts/test_live_catalog_contract.py` pins the captured Ibyte snapshot against
a Python port of `CatalogAdapter`'s normalization/validation rules, so a response
shape drift is caught without PHP. Passing the probe is necessary, not sufficient:
set `DISCOVERY_SOURCES` from the verified JSON, migrate, and watch one poll cycle
before trusting the inbox.

The poller identifies itself with `User-Agent: <APP_NAME>/<APP_VERSION>`. A live
2026-11-02 check confirmed Ibyte serves the catalog to that agent but returns
HTTP 403 to Guzzle's default `GuzzleHttp/...` agent, so the header is required,
not cosmetic; the probe sends the same style of agent. This is best-effort
etiquette toward the retailer, not a way to defeat a block that is deliberately
enforced (Carrefour 403s the probe's own agent too and stays disabled).
A failed source is isolated and backs off from 120 seconds to at most an hour.
Each run fetches at most one response per configured source, with a 20-second
timeout, a post-download 5 MB limit and at most 500 normalized offers. It refuses
redirects. The body cap is not a streaming download limit. Configure bounded
catalog queries; this is intentionally not a full-catalog crawler or pagination
engine. Status exposes last check and health; it is not an uptime monitor.

```sh
php artisan migrate --force
php artisan discovery:poll --force
php artisan schedule:list
```

Supervisor's existing schedule:work runs the command each minute; source intervals
control the actual network frequency. The scheduler lock avoids overlapping polls.
All queue/cache/database infrastructure remains the existing Laravel setup.

## Personalized automation contract

POST `/api/v1/discovery/my-automation/events` with JSON:

```json
{"observed_at":"2026-10-28T14:00:00-03:00","offers":[{"sku":"product123:seller1","title":"RTX 5070 12GB","path":"/rtx-5070/p","price":2499.90,"available":true}]}
```

Prices are BRL for one SKU/seller and one payment basis. Keep seller/payment basis
in the SKU identity if they differ; do not mix installment totals with PIX prices.
Do not subtract an unverified coupon or assume zero shipping. `path` is a retailer
catalog path without query, fragment, hostname, percent escapes or traversal.
The receiver builds `origin + path`; it does not follow links or maintain an
affiliate-parameter blacklist. If a store requires query-based product identities,
add a catalog-ID adapter rather than stripping arbitrary parameters. AFFILIATE_ENABLED
is false in both Render blueprints, disabling the upstream app's own link tagging.

Set a strong DISCOVERY_WEBHOOK_SECRET. Sign the **exact** raw JSON body:

```python
import hashlib, hmac, json, time, urllib.request
from datetime import datetime, timezone
# Capture this at collection time; retain it unchanged on delivery retries.
observed_at = datetime.now(timezone.utc).isoformat()
body = json.dumps({"observed_at": observed_at, "offers": offers}, separators=(",", ":")).encode()
source = "my-automation"
timestamp = str(int(time.time()))
signature = hmac.new(secret.encode(), timestamp.encode() + b"." + source.encode() + b"." + body, hashlib.sha256).hexdigest()
request = urllib.request.Request(base_url + "/api/v1/discovery/" + source + "/events", body, {
    "Content-Type": "application/json", "Accept": "application/json",
    "X-Discovery-Timestamp": timestamp, "X-Discovery-Signature": signature,
})
with urllib.request.urlopen(request, timeout=30) as response:
    print(response.status)
```

Only trusted producers receive the shared secret. It authorizes all configured
sources. Signatures bind the source and expire after five minutes. Exact retries
upsert the same SKU/day/watch records rather than creating duplicates. Older observations and exact timestamp retries are ignored per source/SKU.
They cannot overwrite a newer price, append a daily sample or extend expiry.
`observed_at` is required for push events and must be an ISO 8601 timestamp with
an explicit timezone, optionally with up to six fractional second digits. It
must be no more than 30 minutes old or 30 seconds ahead. A producer must use
strictly increasing observation times for successive snapshots; conflicting
values with the same timestamp do not override the first one. Expiry is measured
from collection time, not delivery time. This does not provide a durable
exactly-once queue. The producer must retry failed submissions and
retain its own delivery cursor. Payloads are ingested synchronously in per-offer
transactions. A failed batch may be partially committed; retry the whole batch.
For a VTEX push source, wrap the native product array as
`{"observed_at":"...","products":[...]}`; polling still accepts the native array.
A producer must report unavailable offers explicitly; an omitted offer ages out
of the inbox after 30 minutes. Never keep replaying an old catalog as fresh.

## Matching and retention

Watches need explicit `config.keywords` (case-insensitive OR by default), optional
`rules.store_allowlist`, and either `rules.max_price` or a historical drop rule.
`config.keyword_mode=all` requires every keyword; `config.exclude_keywords`
rejects a title containing any excluded term. Both modes compare title substrings.
The Android form exposes these controls and preferred stores.
Names alone do not match the catalog. Android's new form creates these values.
A target-only watch works immediately. `min_pct_below_30d` needs at least seven
separate prior days and compares against the median of observed daily samples
within the last 30 days, excluding today. Without target/drop rules, the threshold
is 10%. Retailer MSRP is never treated as observed history. Daily samples use the
latest observed available price of that day; they are not a complete intraday
history and will miss short-lived lows. Zero/out-of-stock prices do not enter
history. Seller identity comes from the source's SKU; changing it resets history.

Each matched offer gets a reason and a 30-minute expiry, refreshed on observation.
An increased price, unavailable stock or changed watch rule removes it from the
visible inbox. No match is shown to another user. The engine keeps compact daily
baselines for candidates (needed to learn a genuine discount) but only qualifying
matches enter the inbox. Samples and inactive offers are pruned after 31 days.
Existing product price history is untouched. This slice does not implement
90-day/record-low watch rules: those fail closed instead of claiming unsupported
confidence. Coupon/brand/category/product watch types currently all use explicit
keywords, not product-family or category taxonomy resolution.

GET `/api/v1/deals` requires Sanctum + watches:read, returns at most 100 fresh
matches. GET `/api/v1/discovery/sources` returns public source names/origins and
health, never endpoint secrets. The current mobile inbox is discovery polling;
new matches and further price drops create database alert notifications, subject
to the watch cooldown and its app channel setting. Same-price refreshes do not send duplicate alerts.
A price drop suppressed during cooldown is not queued for later replay. Delivery
is two-layered and opt-in: the watch's `app` channel decides whether the match
alerts at all (database inbox), and FCM push is added only when the app-level
`fcm` notification service is enabled in Settings. The database inbox is written
either way. When enabled, the alert is pushed to the user's registered devices
(`/api/v1/devices`) with `data` keys mirroring the inbox (`type`, `watch_id`,
`url`, `observed_at`). With no FCM server key configured the send is a safe
no-op, so hosting stays free/best-effort until a host opts in.
The legacy alert flow now shares this FCM path: `PriceAlertNotification` and
`StockAlertNotification` each expose a `toFcm()` with the same string-typed
`data` shape (`type` `price_drop`/`back_in_stock`, plus `url`, `buy_url`,
`url_id`, `product_id`, `store_name` and `price` for drops). They push only when
the `fcm` service is enabled and the user has registered devices; otherwise the
database/mail/other channels are unaffected, so FCM is complete across discovery,
price-drop and back-in-stock alerts without changing existing behavior.
The app refreshes every minute while foregrounded and supports manual refresh.
The existing alert inbox remains separate. Shipping is unknown until checkout.

## Build and validation

Android 1.1.0+2 includes deal cards, source health/filtering, direct-store actions,
keyword/target watches, restored-session routing and login/network errors. Release
manifest includes INTERNET; default API is the existing production HTTPS host.
The new backend must deploy before the deal feed endpoint becomes available.
The empty-source state is explicit; there are no fabricated deals.

`mobile/README.md` contains reproducible build commands. `.github/workflows/android.yml`
checks the app and uploads an installable debug preview APK on an eligible push,
PR, or manual run. A debug preview is not a store-signed production release.
A real release needs a private signing key and verified Firebase configuration.
