<?php

/**
 * Prove that every retailer snapshot captured by scripts/probe_discovery_sources.py
 * passes the real PHP CatalogAdapter normalization rules (path regex, traversal
 * rejection, positive-price-for-available-offers, origin contract).
 *
 * A source must clear this gate — not just the Python verify() shape check —
 * before it can be added to DISCOVERY_SOURCES in production. Run:
 *   php scripts/verify_snapshots_via_php_adapter.php
 *
 * Snapshots live under source-probe/ (gitignored); the list comes from
 * source-probe/verified-sources.json produced by the probe.
 */

require __DIR__.'/../vendor/autoload.php';

$app = require __DIR__.'/../bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

$adapter = new App\Services\Discovery\CatalogAdapter;
$probeDir = realpath(__DIR__.'/../source-probe');
if (! $probeDir) {
    fwrite(STDERR, "Run scripts/probe_discovery_sources.py first — source-probe/ missing.\n");

    return 1;
}

$verified = json_decode(file_get_contents($probeDir.'/verified-sources.json'), true, 512, JSON_THROW_ON_ERROR);
if (! is_array($verified) || $verified === []) {
    fwrite(STDERR, "No verified sources to check.\n");

    return 1;
}

$total = 0;
$failures = 0;
foreach ($verified as $id => $source) {
    $snapshotPath = $probeDir.'/'.$id.'.json';
    if (! is_file($snapshotPath)) {
        echo str_pad($id, 26)." -> MISSING snapshot file\n";
        $failures++;

        continue;
    }
    $payload = json_decode(file_get_contents($snapshotPath), true, 512, JSON_THROW_ON_ERROR);
    try {
        $rows = $adapter->normalize($source, $payload);
        $available = array_filter($rows, fn (array $row): bool => $row['available']);
        $sampleUrl = $rows[0]['url'] ?? '';
        $total += count($rows);
        echo str_pad($id, 26).' -> normalized='.count($rows).' available='.count($available).' sample='.$sampleUrl."\n";
    } catch (Throwable $e) {
        echo str_pad($id, 26).' -> FAILED: '.$e->getMessage()."\n";
        $failures++;
    }
}

echo "---\n";
if ($failures === 0) {
    echo 'ALL PASS (sources='.count($verified).", total rows=$total)\n";
} else {
    echo "$failures source(s) failed (rows=$total)\n";
}

return $failures === 0 ? 0 : 1;
