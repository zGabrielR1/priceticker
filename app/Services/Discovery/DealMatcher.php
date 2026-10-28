<?php

namespace App\Services\Discovery;

use App\Models\Watch;

class DealMatcher
{
    public function reason(Watch $watch, array $offer, array $history, string $source): ?string
    {
        if (! $offer['available'] || ! $watch->is_active) {
            return null;
        }
        // A name alone is not an unrestricted watch. Explicit keywords are required.
        $keywords = array_filter((array) $watch->configValue('keywords', []), 'is_string');
        if (! $keywords || ! collect($keywords)->contains(fn ($word) => trim($word) !== '' && mb_stripos($offer['title'], trim($word)) !== false)) {
            return null;
        }
        if ($watch->storeAllowlist() && ! in_array($source, $watch->storeAllowlist(), true)) {
            return null;
        }
        $price = (float) $offer['price'];
        if ($watch->maxPrice() !== null && $price > $watch->maxPrice()) {
            return null;
        }
        // These rules need a separate 90-day/product identity model: fail closed.
        if ($watch->minPctBelow90d() !== null || $watch->recordLowOnly()) {
            return null;
        }
        $minimum = $watch->minPctBelow30d();
        if ($minimum !== null || $watch->maxPrice() === null) {
            // At least seven different days, excluding today; never trust an MSRP.
            if (count($history) < 7) {
                return null;
            }
            sort($history, SORT_NUMERIC);
            $n = count($history);
            $median = ($history[intdiv($n - 1, 2)] + $history[intdiv($n, 2)]) / 2;
            $drop = $median > 0 ? (1 - $price / $median) * 100 : 0;
            if ($drop < max(0.01, $minimum ?? 10)) {
                return null;
            }

            return sprintf('%.1f%% below the observed 30-day median (%d days)', $drop, $n);
        }

        return 'Within your target price; shipping is not included';
    }
}
