<?php

namespace Tests\Feature\Api\V1;

use App\Models\User;
use App\Models\Watch;
use App\Services\Discovery\CatalogAdapter;
use App\Services\Discovery\DealMatcher;
use App\Services\Discovery\DiscoveryIngestor;
use Carbon\CarbonImmutable;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Schema;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class DiscoveryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        // A dedicated SQLite connection makes this suite independent of hosted data.
        config(['database.default' => 'sqlite', 'database.connections.sqlite.database' => ':memory:', 'cache.default' => 'array']);
        DB::purge('sqlite');
        Schema::create('users', function (Blueprint $table) {
            $table->id();
        });
        (require database_path('migrations/2025_01_21_115343_create_notifications_table.php'))->up();
        (require database_path('migrations/2026_10_17_000000_create_watches_table.php'))->up();
        (require database_path('migrations/2026_10_28_000000_create_discovery_tables.php'))->up();
        (require database_path('migrations/2026_10_28_010000_add_discovery_observation_watermark.php'))->up();
        DB::table('users')->insert([['id' => 1], ['id' => 2]]);
        config(['discovery.sources' => ['retailer' => ['origin' => 'https://store.example', 'driver' => 'json']]]);
    }

    private function watch(int $user = 1, array $rules = ['max_price' => 100]): Watch
    {
        return Watch::create(['user_id' => $user, 'type' => 'product', 'name' => 'GPU', 'config' => ['keywords' => ['RTX']], 'rules' => $rules, 'is_active' => true]);
    }

    private function rows(float $price = 90, bool $available = true): array
    {
        return app(CatalogAdapter::class)->normalize(config('discovery.sources.retailer'), ['offers' => [[
            'sku' => 'sku-1:seller-1', 'title' => 'RTX graphics card', 'path' => '/rtx/p', 'price' => $price, 'available' => $available,
        ]]]);
    }

    public function test_retries_are_idempotent_and_expensive_or_unavailable_offers_disappear(): void
    {
        $this->watch();
        $ingestor = app(DiscoveryIngestor::class);
        $this->assertSame(1, $ingestor->ingest('retailer', $this->rows()));
        $ingestor->ingest('retailer', $this->rows());
        $this->assertSame(1, DB::table('discovery_offers')->count());
        $this->assertSame(1, DB::table('discovery_samples')->count());
        $this->assertSame(1, DB::table('discovery_matches')->count());
        $this->assertSame(1, DB::table('notifications')->count());
        $ingestor->ingest('retailer', $this->rows(120));
        $this->assertSame(0, DB::table('discovery_matches')->count());
        $ingestor->ingest('retailer', $this->rows(80, false));
        $this->assertSame(0, DB::table('discovery_matches')->count());
    }

    public function test_inbox_is_owned_expires_and_rechecks_edited_rules(): void
    {
        $watch = $this->watch();
        $this->watch(2);
        app(DiscoveryIngestor::class)->ingest('retailer', $this->rows());
        Sanctum::actingAs(User::findOrFail(1), ['watches:read']);
        $this->getJson('/api/v1/deals')->assertOk()->assertJsonCount(1, 'data');
        $watch->update(['rules' => ['max_price' => 50]]);
        $this->getJson('/api/v1/deals')->assertOk()->assertJsonCount(0, 'data');
        $watch->update(['rules' => ['max_price' => 100]]);
        $this->travel(31)->minutes();
        $this->getJson('/api/v1/deals')->assertOk()->assertJsonCount(0, 'data');
    }

    public function test_old_and_replayed_observations_cannot_rewind_price_or_extend_expiry(): void
    {
        $this->watch();
        $ingestor = app(DiscoveryIngestor::class);
        $observed = CarbonImmutable::now()->subMinutes(2);
        $ingestor->ingest('retailer', $this->rows(90), $observed);
        $expiry = DB::table('discovery_matches')->value('expires_at');
        $ingestor->ingest('retailer', $this->rows(50), $observed->subMinute());
        $ingestor->ingest('retailer', $this->rows(90), $observed);
        $this->assertEquals(90, DB::table('discovery_offers')->value('price'));
        $this->assertSame($expiry, DB::table('discovery_matches')->value('expires_at'));
        $this->assertSame(1, DB::table('notifications')->count());
        $ingestor->ingest('retailer', $this->rows(95), $observed->addMinute());
        $this->assertEquals(95, DB::table('discovery_offers')->value('price'));
    }

    public function test_stale_and_future_observations_are_rejected_before_persistence(): void
    {
        foreach ([CarbonImmutable::now()->subMinutes(31), CarbonImmutable::now()->addMinutes(2)] as $observed) {
            try {
                app(DiscoveryIngestor::class)->ingest('retailer', $this->rows(), $observed);
                $this->fail('Invalid observation time accepted');
            } catch (\Illuminate\Validation\ValidationException $e) {
                $this->assertArrayHasKey('observed_at', $e->errors());
            }
        }
        $this->assertSame(0, DB::table('discovery_offers')->count());
    }

    public function test_keyword_modes_exclusions_and_preferred_stores(): void
    {
        $watch = $this->watch();
        $watch->config = ['keywords' => ['RTX', 'graphics'], 'keyword_mode' => 'all', 'exclude_keywords' => ['used']];
        $matcher = app(DealMatcher::class);
        $row = $this->rows()[0];
        $this->assertNotNull($matcher->reason($watch, $row, [], 'retailer'));
        $row['title'] = 'RTX used graphics card';
        $this->assertNull($matcher->reason($watch, $row, [], 'retailer'));
        $row['title'] = 'RTX card';
        $this->assertNull($matcher->reason($watch, $row, [], 'retailer'));
        $watch->config = ['keywords' => ['RTX', 'graphics'], 'keyword_mode' => 'any'];
        $this->assertNotNull($matcher->reason($watch, $row, [], 'retailer'));
        $watch->rules = ['max_price' => 100, 'store_allowlist' => ['another-retailer']];
        $this->assertNull($matcher->reason($watch, $row, [], 'retailer'));
    }

    public function test_watch_api_validates_discovery_controls(): void
    {
        Sanctum::actingAs(User::findOrFail(1), ['watches:write']);
        $this->postJson('/api/v1/watches', [
            'type' => 'product', 'name' => 'GPU',
            'config' => ['keywords' => [123], 'keyword_mode' => 'unknown'],
            'rules' => ['max_price' => -1, 'min_pct_below_30d' => 110, 'cooldown_minutes' => -1],
        ])->assertUnprocessable()->assertJsonValidationErrors([
            'config.keywords.0', 'config.keyword_mode', 'rules.max_price', 'rules.min_pct_below_30d', 'rules.cooldown_minutes',
        ]);
        $this->postJson('/api/v1/watches', [
            'type' => 'product', 'name' => 'GPU',
            'config' => ['keywords' => ['RTX'], 'keyword_mode' => 'all', 'exclude_keywords' => ['used'], 'urls' => ['https://store.example/rtx/p']],
            'rules' => ['max_price' => 100, 'store_allowlist' => ['retailer']],
        ])->assertCreated()->assertJsonPath('data.config.keyword_mode', 'all')->assertJsonPath('data.config.urls.0', 'https://store.example/rtx/p');
    }

    public function test_late_observation_uses_its_original_day_and_expiry(): void
    {
        $this->travelTo(CarbonImmutable::parse('2026-10-28 00:05:00'));
        $this->watch();
        $observed = CarbonImmutable::parse('2026-10-27 23:55:00');
        app(DiscoveryIngestor::class)->ingest('retailer', $this->rows(), $observed);
        $this->assertSame('2026-10-27', DB::table('discovery_samples')->value('day'));
        $expiry = CarbonImmutable::parse(DB::table('discovery_matches')->value('expires_at'));
        $this->assertSame('2026-10-28 00:25:00', $expiry->format('Y-m-d H:i:s'));
        $data = json_decode(DB::table('notifications')->value('data'), true);
        $this->assertSame($observed->toIso8601String(), $data['observed_at']);
    }

    public function test_inbox_batches_history_queries_instead_of_querying_every_card(): void
    {
        $this->watch();
        $rows = [];
        for ($i = 0; $i < 20; $i++) {
            $row = $this->rows()[0];
            $row['sku'] = 'sku-'.$i;
            $rows[] = $row;
        }
        app(DiscoveryIngestor::class)->ingest('retailer', $rows);
        Sanctum::actingAs(User::findOrFail(1), ['watches:read']);
        DB::enableQueryLog();
        DB::flushQueryLog();
        $this->getJson('/api/v1/deals')->assertOk()->assertJsonCount(20, 'data');
        $queries = collect(DB::getQueryLog())->filter(fn ($query) => str_contains($query['query'], 'discovery_samples'));
        DB::disableQueryLog();
        $this->assertCount(1, $queries);
    }

    public function test_further_drops_alert_only_after_watch_cooldown(): void
    {
        $this->watch();
        $ingestor = app(DiscoveryIngestor::class);
        $ingestor->ingest('retailer', $this->rows());
        $ingestor->ingest('retailer', $this->rows(80));
        $this->assertSame(1, DB::table('notifications')->count());
        $this->travel(61)->minutes();
        $ingestor->ingest('retailer', $this->rows(70));
        $this->assertSame(2, DB::table('notifications')->count());
    }

    public function test_historical_discount_needs_seven_days_and_uses_even_median(): void
    {
        $watch = $this->watch(1, ['min_pct_below_30d' => 10]);
        $matcher = app(DealMatcher::class);
        $row = $this->rows()[0];
        $this->assertNull($matcher->reason($watch, $row, [100, 100], 'retailer'));
        $this->assertNotNull($matcher->reason($watch, $row, array_fill(0, 7, 110), 'retailer'));
        $this->assertNull($matcher->reason($watch, $row, [50, 50, 50, 50, 100, 100, 100, 100], 'retailer'));
        $watch->config = [];
        $this->assertNull($matcher->reason($watch, $row, array_fill(0, 7, 110), 'retailer'));
    }

    public function test_webhook_authentication_replay_window_and_source_binding(): void
    {
        config(['discovery.webhook_secret' => 'test-secret']);
        $body = json_encode(['observed_at' => now()->toIso8601String(), 'offers' => [['sku' => 'sku', 'title' => 'RTX', 'path' => '/rtx/p', 'price' => 90, 'available' => true]]]);
        $send = function (int $timestamp, string $signedSource = 'retailer') use ($body) {
            return $this->call('POST', '/api/v1/discovery/retailer/events', [], [], [], [
                'CONTENT_TYPE' => 'application/json', 'HTTP_ACCEPT' => 'application/json',
                'HTTP_X_DISCOVERY_TIMESTAMP' => (string) $timestamp,
                'HTTP_X_DISCOVERY_SIGNATURE' => hash_hmac('sha256', $timestamp.'.'.$signedSource.'.'.$body, 'test-secret'),
            ], $body);
        };
        $this->postJson('/api/v1/discovery/retailer/events', [])->assertUnauthorized();
        $send(time() - 301)->assertUnauthorized();
        $send(time(), 'another-store')->assertUnauthorized();
        $send(time())->assertOk()->assertJsonPath('accepted', 1);
    }

    public function test_vtex_preserves_seller_identity_and_uses_current_price(): void
    {
        $rows = app(CatalogAdapter::class)->normalize(['driver' => 'vtex', 'origin' => 'https://store.example'], [[
            'productName' => 'RTX', 'linkText' => 'rtx', 'items' => [[
                'itemId' => '123', 'sellers' => [
                    ['sellerId' => 'one', 'commertialOffer' => ['Price' => 90, 'ListPrice' => 999, 'AvailableQuantity' => 2]],
                    ['sellerId' => 'two', 'commertialOffer' => ['Price' => 0, 'AvailableQuantity' => 0]],
                ],
            ]],
        ]]);
        $this->assertSame('123:one', $rows[0]['sku']);
        $this->assertSame('123:two', $rows[1]['sku']);
        $this->assertSame(90, $rows[0]['price']);
        $this->assertSame('https://store.example/rtx/p', $rows[0]['url']);
        $this->assertFalse($rows[1]['available']);
        $this->watch();
        app(DiscoveryIngestor::class)->ingest('retailer', [$rows[1]]);
        $this->assertSame(0, DB::table('discovery_samples')->count());
    }

    public function test_missing_feed_envelope_does_not_count_as_a_successful_empty_catalog(): void
    {
        config(['discovery.sources.retailer.endpoint' => 'https://store.example/catalog']);
        Http::fake(['*' => Http::response(['error' => 'upstream failure'], 200)]);
        $this->artisan('discovery:poll')->assertFailed();
        $this->assertFalse(Cache::get('discovery:status:retailer')['healthy']);
        $this->assertSame(0, DB::table('discovery_offers')->count());
    }

    public function test_explicit_empty_catalog_is_accepted(): void
    {
        $this->assertSame([], app(CatalogAdapter::class)->normalize(config('discovery.sources.retailer'), ['offers' => []]));
    }

    public function test_catalog_rejects_redirects_query_strings_and_traversal(): void
    {
        foreach (['//evil.example/p', '/product?affiliate=1', '/product#tag', '/../secret', '/%2f%2fevil'] as $path) {
            try {
                app(CatalogAdapter::class)->normalize(config('discovery.sources.retailer'), ['offers' => [['sku' => 's', 'title' => 't', 'path' => $path, 'price' => 10, 'available' => true]]]);
                $this->fail('Unsafe catalog path accepted');
            } catch (\InvalidArgumentException $e) {
                $this->assertStringContainsString('catalog path', $e->getMessage());
            }
        }
    }

    public function test_polling_is_bounded_and_failure_backoff_is_visible(): void
    {
        config(['discovery.sources.retailer.endpoint' => 'https://store.example/catalog']);
        Http::fake(['*' => Http::response('blocked', 429)]);
        $this->artisan('discovery:poll')->assertFailed();
        $this->assertFalse(Cache::get('discovery:status:retailer')['healthy']);
        $this->artisan('discovery:poll')->assertSuccessful();
        Http::assertSentCount(1);
    }
}
