<?php

namespace App\Console\Commands;

use App\Services\Discovery\CatalogAdapter;
use App\Services\Discovery\DiscoveryIngestor;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Throwable;

class DiscoverDeals extends Command
{
    protected $signature = 'discovery:poll {--force : Ignore source polling interval}';

    protected $description = 'Poll bounded direct retailer catalogs and persist personalized deals';

    public function handle(CatalogAdapter $adapter, DiscoveryIngestor $ingestor): int
    {
        $failed = false;
        foreach (config('discovery.sources', []) as $id => $source) {
            if (empty($source['endpoint'])) {
                continue; // Push-only source.
            }
            if (! $this->option('force') && ! Cache::add('discovery:due:'.$id, true, max(60, (int) ($source['interval_seconds'] ?? 300)))) {
                continue;
            }
            try {
                // Endpoints are operator configuration. No redirects to affiliate/other hosts.
                $response = Http::acceptJson()->timeout(20)->withoutRedirecting()->get($source['endpoint']);
                if (! $response->successful()) {
                    throw new \RuntimeException('Catalog HTTP '.$response->status());
                }
                if (strlen($response->body()) > 5_000_000) {
                    throw new \RuntimeException('Catalog exceeds 5 MB budget');
                }
                $rows = $adapter->normalize($source, $response->json());
                $matches = $ingestor->ingest((string) $id, $rows);
                Cache::put('discovery:status:'.$id, ['checked_at' => now()->toIso8601String(), 'offers' => count($rows), 'matches' => $matches, 'healthy' => true], now()->addDays(7));
                $this->info($id.': '.count($rows).' offers, '.$matches.' matches');
            } catch (Throwable $e) {
                // Isolate failing stores and back off rather than spinning on blocks.
                $failures = min(6, (int) Cache::get('discovery:failures:'.$id, 0) + 1);
                Cache::put('discovery:failures:'.$id, $failures, now()->addDay());
                Cache::put('discovery:due:'.$id, true, min(3600, 60 * (2 ** $failures)));
                Cache::put('discovery:status:'.$id, ['checked_at' => now()->toIso8601String(), 'healthy' => false], now()->addDays(7));
                $this->error($id.': '.$e->getMessage());
                $failed = true;

                continue;
            }
            Cache::forget('discovery:failures:'.$id);
        }
        DB::table('discovery_matches')->where('expires_at', '<', now())->delete();
        DB::table('discovery_samples')->where('day', '<', now()->subDays(31)->toDateString())->delete();
        DB::table('discovery_offers')->where('observed_at', '<', now()->subDays(31))->delete();

        return $failed ? self::FAILURE : self::SUCCESS;
    }
}
