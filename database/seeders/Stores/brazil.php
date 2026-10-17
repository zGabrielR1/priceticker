<?php

return [
    // Brazilian retailers. Strategies prefer schema.org (most robust) and fall
    // back to common meta tags. Locale/currency are pt_BR / BRL so price history
    // and insights stay consistent. Run: php artisan buddy:create-stores brazil
    [
        'name' => 'KaBuM!',
        'slug' => 'kabum',
        'domains' => [
            ['domain' => 'kabum.com.br'],
            ['domain' => 'www.kabum.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'http',
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'schema_org'],
            'price' => ['type' => 'schema_org'],
            'image' => ['type' => 'schema_org'],
            'availability' => ['type' => 'schema_org'],
        ],
    ],
    [
        'name' => 'Pichau',
        'slug' => 'pichau',
        'domains' => [
            ['domain' => 'pichau.com.br'],
            ['domain' => 'www.pichau.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'http',
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'schema_org'],
            'price' => ['type' => 'schema_org'],
            'image' => ['type' => 'schema_org'],
            'availability' => ['type' => 'schema_org'],
        ],
    ],
    [
        'name' => 'Terabyte',
        'slug' => 'terabyte',
        'domains' => [
            ['domain' => 'terabyteshop.com.br'],
            ['domain' => 'www.terabyteshop.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'http',
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'schema_org'],
            'price' => ['type' => 'schema_org'],
            'image' => ['type' => 'schema_org'],
            'availability' => ['type' => 'schema_org'],
        ],
    ],
    [
        'name' => 'Mercado Livre',
        'slug' => 'mercado-livre',
        'domains' => [
            ['domain' => 'mercadolivre.com.br'],
            ['domain' => 'www.mercadolivre.com.br'],
            ['domain' => 'produto.mercadolivre.com.br'],
            ['domain' => 'lista.mercadolivre.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'http',
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'schema_org'],
            'price' => ['type' => 'schema_org'],
            'image' => ['type' => 'schema_org'],
            'availability' => ['type' => 'schema_org'],
        ],
    ],
    [
        'name' => 'Amazon BR',
        'slug' => 'amazon-br',
        'domains' => [
            ['domain' => 'amazon.com.br'],
            ['domain' => 'www.amazon.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'api',
            'missing_price_out_of_stock' => true,
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'selector', 'value' => '#productTitle'],
            'price' => ['type' => 'selector', 'value' => '.a-price > .a-offscreen'],
            'image' => ['type' => 'selector', 'value' => '#landingImage|src'],
            'availability' => ['type' => 'selector', 'value' => '#availability'],
        ],
    ],
    [
        'name' => 'Magalu',
        'slug' => 'magalu',
        'domains' => [
            ['domain' => 'magazineluiza.com.br'],
            ['domain' => 'www.magazineluiza.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'api',
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'schema_org'],
            'price' => ['type' => 'schema_org'],
            'image' => ['type' => 'schema_org'],
            'availability' => ['type' => 'schema_org'],
        ],
    ],
    [
        'name' => 'Shopee BR',
        'slug' => 'shopee-br',
        'domains' => [
            ['domain' => 'shopee.com.br'],
            ['domain' => 'www.shopee.com.br'],
        ],
        'settings' => [
            'locale_settings' => [
                'locale' => 'pt_BR',
                'currency' => 'BRL',
            ],
            'scraper_service' => 'api',
        ],
        'scrape_strategy' => [
            'title' => ['type' => 'schema_org'],
            'price' => ['type' => 'schema_org'],
            'image' => ['type' => 'schema_org'],
            'availability' => ['type' => 'schema_org'],
        ],
    ],
];
