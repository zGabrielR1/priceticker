<?php

namespace App\Services\Scrapers;

use Exception;
use Illuminate\Support\Facades\Cache;
use Jez500\WebScraperForLaravel\WebScraperApi;

class BrowserWebScraperApi extends WebScraperApi
{
    public function __construct()
    {
        parent::__construct();
        $this->setScraperApiBaseUrl((string) config('price_buddy.scraper_api_url', 'http://scraper:3000'));
    }

    public function get(): self
    {
        $key = $this->getCacheKey($this->url);
        $cached = $this->useCache ? Cache::get($key) : null;
        if (is_string($cached) && $cached !== '') {
            $this->body = $cached;

            return $this;
        }

        try {
            $response = $this->getRequest()->get($this->getScraperApiBaseUrl(), $this->getRequestParams());
            $html = $response->json('fullContent');
            if ($response->failed() || ! is_string($html) || $html === '') {
                $this->errors[] = [
                    'message' => 'The browser service could not render the product page.',
                    'code' => $response->failed() ? $response->status() : 204,
                ];
                $this->body = '';

                return $this;
            }

            $this->body = $html;
            if ($this->useCache) {
                Cache::put($key, $html, now()->addMinutes($this->cacheMinsTtl));
            }
        } catch (Exception) {
            $this->body = '';
            $this->errors[] = ['message' => 'The browser service could not be reached or timed out.', 'code' => 503];
        }

        return $this;
    }
}
