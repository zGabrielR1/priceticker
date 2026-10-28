<?php

namespace App\Services\Discovery;

use Illuminate\Support\Facades\Validator;
use InvalidArgumentException;

class CatalogAdapter
{
    public function normalize(array $source, array $payload): array
    {
        if (($source['driver'] ?? '') === 'vtex') {
            $rows = [];
            foreach ($payload as $product) {
                foreach ($product['items'] ?? [] as $sku) {
                    foreach ($sku['sellers'] ?? [] as $seller) {
                        $offer = $seller['commertialOffer'] ?? [];
                        $rows[] = [
                            'sku' => ($sku['itemId'] ?? '').':'.($seller['sellerId'] ?? ''),
                            'title' => $product['productName'] ?? '',
                            // Build a retailer URL from its catalog identity, never an affiliate redirect.
                            'path' => '/'.($product['linkText'] ?? '').'/p',
                            'price' => $offer['Price'] ?? 0,
                            'available' => ($offer['AvailableQuantity'] ?? 0) > 0,
                        ];
                    }
                }
            }
        } else {
            $rows = $payload['offers'] ?? [];
        }
        Validator::make(['offers' => $rows], [
            'offers' => ['present', 'array', 'max:500'],
            'offers.*.sku' => ['required', 'string', 'max:160'],
            'offers.*.title' => ['required', 'string', 'max:255'],
            'offers.*.path' => ['required', 'string', 'max:2000'],
            'offers.*.price' => ['required', 'numeric', 'min:0', 'max:9999999999.99'],
            'offers.*.available' => ['required', 'boolean'],
        ])->validate();
        $origin = rtrim($source['origin'], '/');
        if (! preg_match('~^https://[a-z0-9.-]+$~i', $origin)) {
            throw new InvalidArgumentException('Source origin must be an HTTPS retailer hostname.');
        }
        foreach ($rows as &$row) {
            if ($row['available'] && (float) $row['price'] <= 0) {
                throw new InvalidArgumentException('An available offer must have a positive price.');
            }
            // Clean path contract: producers supply catalog paths, not arbitrary links.
            if (! preg_match('~^/[a-zA-Z0-9/_%.+\-]+$~D', $row['path']) || str_contains($row['path'], '..') || str_contains($row['path'], '%') || str_starts_with($row['path'], '//')) {
                throw new InvalidArgumentException('Expected a retailer catalog path without query or fragment.');
            }
            $row['url'] = $origin.$row['path'];
        }

        return $rows;
    }
}
