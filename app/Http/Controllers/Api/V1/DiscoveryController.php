<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Watch;
use App\Services\Discovery\CatalogAdapter;
use App\Services\Discovery\DealMatcher;
use App\Services\Discovery\DiscoveryIngestor;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class DiscoveryController
{
    public function index(Request $request): JsonResponse
    {
        $rows = DB::table('discovery_matches as matches')
            ->join('watches', 'watches.id', '=', 'matches.watch_id')
            ->join('discovery_offers as offers', 'offers.id', '=', 'matches.offer_id')
            ->where('watches.user_id', $request->user()->id)->where('watches.is_active', true)
            ->where('matches.expires_at', '>', now())->where('offers.available', true)
            ->orderByDesc('offers.observed_at')->limit(100)
            ->select('offers.*', 'matches.reason', 'matches.watch_id', 'matches.expires_at', 'watches.name as watch_name')->get();
        // Re-evaluate current rules so edits cannot leave obsolete matches visible.
        $watches = Watch::where('user_id', $request->user()->id)->get()->keyBy('id');
        $rows = $rows->filter(function ($row) use ($watches) {
            $history = DB::table('discovery_samples')->where('offer_id', $row->id)
                ->where('day', '>=', now()->subDays(30)->toDateString())->where('day', '<', now()->toDateString())
                ->pluck('price')->map(fn ($p) => (float) $p)->all();

            return app(DealMatcher::class)->reason($watches[$row->watch_id], (array) $row, $history, $row->source) !== null;
        })->values();

        $rows->each(function ($row) {
            $row->observed_at = \Carbon\Carbon::parse($row->observed_at)->toIso8601String();
            $row->expires_at = \Carbon\Carbon::parse($row->expires_at)->toIso8601String();
        });

        return response()->json(['data' => $rows, 'checked_at' => now()->toIso8601String()]);
    }

    public function sources(): JsonResponse
    {
        $sources = [];
        foreach (config('discovery.sources', []) as $id => $source) {
            $sources[] = ['id' => $id, 'name' => $source['name'] ?? $id, 'origin' => $source['origin'], 'status' => Cache::get('discovery:status:'.$id)];
        }

        return response()->json(['data' => $sources]);
    }

    public function ingest(Request $request, string $source, CatalogAdapter $adapter, DiscoveryIngestor $ingestor): JsonResponse
    {
        $secret = config('discovery.webhook_secret');
        $timestamp = $request->header('X-Discovery-Timestamp', '');
        abort_unless($secret && ctype_digit($timestamp) && abs(time() - (int) $timestamp) <= 300, 401);
        $expected = hash_hmac('sha256', $timestamp.'.'.$source.'.'.$request->getContent(), $secret);
        abort_unless(hash_equals($expected, $request->header('X-Discovery-Signature', '')), 401);
        $definition = config('discovery.sources', [])[$source] ?? null;
        abort_unless($definition, 404);
        abort_if(strlen($request->getContent()) > 5_000_000, 413);
        $rows = $adapter->normalize($definition, $request->json()->all());
        $matches = $ingestor->ingest($source, $rows);
        Cache::put('discovery:status:'.$source, ['checked_at' => now()->toIso8601String(), 'offers' => count($rows), 'matches' => $matches, 'healthy' => true], now()->addDays(7));

        return response()->json(['accepted' => count($rows), 'matches' => $matches]);
    }
}
