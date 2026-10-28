<?php

namespace App\Services\Scrapers;

use App\Services\Helpers\HtmlEncodingHelper;
use Exception;
use Illuminate\Support\Facades\Cache;
use Jez500\WebScraperForLaravel\WebScraperHttp;

/**
 * The package scraper, with the response body converted to UTF-8 before it is
 * cached or parsed (#203). AppServiceProvider binds it in place of WebScraperHttp.
 */
class Utf8WebScraperHttp extends WebScraperHttp
{
    public function get(): self
    {
        $request = function () {
            try {
                $response = $this->getRequest()->get($this->url);
                if ($response->failed()) {
                    $this->errors[] = ['message' => 'The store returned HTTP '.$response->status().'.', 'code' => $response->status()];

                    return '';
                }

                return HtmlEncodingHelper::toUtf8($response->body(), $response->header('Content-Type'));
            } catch (Exception $e) {
                $this->errors[] = [
                    'message' => $e->getMessage(),
                    'code' => $e->getCode(),
                ];
                logger()->error($e->getMessage());
            }

            return '';
        };

        $key = $this->getCacheKey($this->url);
        $cached = $this->useCache ? Cache::get($key) : null;
        if (is_string($cached) && $cached !== '') {
            $this->body = $cached;
        } else {
            $this->body = $request();
            // A transient network error must not poison the cache for twelve hours.
            if ($this->useCache && $this->body !== '' && $this->errors === []) {
                Cache::put($key, $this->body, now()->addMinutes($this->cacheMinsTtl));
            }
        }

        return $this;
    }
}
