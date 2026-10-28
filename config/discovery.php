<?php

return [
    // Operator-managed: never accept arbitrary fetch URLs from mobile clients.
    // See docs/discovery.md for VTEX and normalized JSON source contracts.
    'sources' => json_decode(env('DISCOVERY_SOURCES', '{}'), true, 512, JSON_THROW_ON_ERROR),
    'webhook_secret' => env('DISCOVERY_WEBHOOK_SECRET', ''),
    'ttl_minutes' => 30,
];
