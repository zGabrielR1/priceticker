<?php

namespace Tests\Unit\Services;

use App\Enums\ScraperService;
use App\Models\Store;
use App\Services\Ai\HealingContext;
use App\Services\ScrapeUrl;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Http;
use Jez500\WebScraperForLaravel\Facades\WebScraper;
use Tests\TestCase;

class HostedScraperTest extends TestCase
{
    use RefreshDatabase;

    private const URL = 'https://www.kabum.com.br/produto/1027869/';

    private function html(): string
    {
        return '<html><script type="application/ld+json">{"@type":"Product","name":"Ryzen 7 9850X3D","offers":{"price":3299.99,"priceCurrency":"BRL"}}</script></html>';
    }

    private function store(): Store
    {
        return new Store([
            'settings' => ['scraper_service' => 'api', 'locale_settings' => ['locale' => 'pt_BR', 'currency' => 'BRL']],
            'scrape_strategy' => ['title' => ['type' => 'schema_org'], 'price' => ['type' => 'schema_org']],
        ]);
    }

    public function test_browser_store_uses_loopback_service(): void
    {
        config(['price_buddy.browser_scraper_enabled' => true, 'price_buddy.scraper_api_url' => 'http://127.0.0.1:3000']);
        Http::preventStrayRequests();
        Http::fake(['127.0.0.1:3000/*' => Http::response(['fullContent' => $this->html()])]);

        $result = ScrapeUrl::new(self::URL)->setMaxAttempts(1)->scrape(['store' => $this->store(), 'use_cache' => false]);

        $this->assertSame('Ryzen 7 9850X3D', $result['title']);
        $this->assertSame('3299.99', $result['price']);
        Http::assertSent(fn ($request) => str_starts_with($request->url(), 'http://127.0.0.1:3000/api/article') && $request['url'] === self::URL);
    }

    public function test_browser_factory_uses_configured_address_for_discovery(): void
    {
        config(['price_buddy.scraper_api_url' => 'http://127.0.0.1:3000']);
        Http::preventStrayRequests();
        Http::fake(['127.0.0.1:3000/*' => Http::response(['fullContent' => $this->html()])]);
        $scraper = WebScraper::api()->from(self::URL)->get();

        $this->assertStringContainsString('Ryzen', $scraper->getBody());
        $this->assertSame([], $scraper->getErrors());
        Http::assertSentCount(1);
    }

    public function test_browser_store_can_use_http_when_browser_disabled(): void
    {
        config(['price_buddy.browser_scraper_enabled' => false]);
        Http::preventStrayRequests();
        Http::fake([self::URL => Http::response($this->html())]);

        $result = ScrapeUrl::new(self::URL)->setMaxAttempts(1)->scrape(['store' => $this->store(), 'use_cache' => false]);

        $this->assertSame('Ryzen 7 9850X3D', $result['title']);
        $this->assertSame('3299.99', $result['price']);
        Http::assertSentCount(1);
    }

    public function test_http_failure_is_reported_and_not_cached(): void
    {
        Http::fake([self::URL => Http::sequence()->push('Access denied', 403)->push($this->html())]);
        $failed = WebScraper::http()->from(self::URL)->get();
        $this->assertSame('', $failed->getBody());
        $this->assertSame(403, $failed->getErrors()[0]['code']);

        $retried = WebScraper::http()->from(self::URL)->get();
        $this->assertStringContainsString('Ryzen', $retried->getBody());
        Http::assertSentCount(2);
    }

    public function test_browser_failure_is_reported_without_poisoning_the_cache(): void
    {
        config(['price_buddy.scraper_api_url' => 'http://browser.test']);
        Http::fake(['browser.test/*' => Http::sequence()->push(['message' => 'Temporary failure'], 502)->push(['fullContent' => $this->html()])]);
        $failed = WebScraper::api()->setScraperApiBaseUrl('http://browser.test')->from(self::URL)->get();
        $this->assertSame('', $failed->getBody());
        $this->assertSame(502, $failed->getErrors()[0]['code']);

        $retried = WebScraper::api()->from(self::URL)->get();
        $this->assertStringContainsString('Ryzen', $retried->getBody());
        Http::assertSentCount(2);
    }

    public function test_meta_extraction_surfaces_a_blocked_retailer_response(): void
    {
        config(['price_buddy.browser_scraper_enabled' => false]);
        $store = $this->store();
        $store->name = 'KaBuM';
        $store->domains = [['domain' => 'www.kabum.com.br']];
        $store->save();
        Http::fake([self::URL => Http::response('Azion - Default error page', 403)]);

        $result = \App\Services\MetaExtractionService::new()->extract(self::URL);

        $this->assertNull($result['price']);
        $this->assertSame([['message' => 'The store returned HTTP 403.', 'code' => 403]], $result['errors']);
    }

    public function test_healing_does_not_claim_browser_use_when_disabled(): void
    {
        config(['price_buddy.browser_scraper_enabled' => false]);
        Http::fake([self::URL => Http::response($this->html())]);
        $context = new HealingContext(self::URL, $this->store(), null);
        $context->fetch(true);
        $this->assertFalse($context->usedBrowser());
        $this->assertSame(ScraperService::Http->value, ScraperService::effective('api'));
    }
}
