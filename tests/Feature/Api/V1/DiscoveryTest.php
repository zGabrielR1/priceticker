<?php

namespace Tests\Feature\Api\V1;

use App\Models\User;
use App\Models\Watch;
use App\Services\Discovery\CatalogAdapter;
use App\Services\Discovery\DealMatcher;
use App\Services\Discovery\DiscoveryIngestor;
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
        $body = json_encode(['offers' => [['sku' => 'sku', 'title' => 'RTX', 'path' => '/rtx/p', 'price' => 90, 'available' => true]]]);
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
