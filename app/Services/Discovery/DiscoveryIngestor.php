<?php

namespace App\Services\Discovery;

use App\Models\User;
use App\Models\Watch;
use App\Notifications\DiscoveryDealNotification;
use Illuminate\Support\Facades\DB;

class DiscoveryIngestor
{
    public function ingest(string $source, array $rows): int
    {
        $count = 0;
        foreach ($rows as $row) {
            $count += DB::transaction(function () use ($source, $row) {
                $now = now();
                $identity = hash('sha256', $source.':'.$row['sku']);
                DB::table('discovery_offers')->insertOrIgnore([
                    'identity' => $identity, 'source' => $source, 'sku' => $row['sku'],
                    'title' => $row['title'], 'url' => $row['url'], 'price' => $row['price'],
                    'available' => $row['available'], 'observed_at' => $now,
                    'created_at' => $now, 'updated_at' => $now,
                ]);
                $offer = DB::table('discovery_offers')->where('identity', $identity)->lockForUpdate()->first();
                DB::table('discovery_offers')->where('id', $offer->id)->update([
                    'title' => $row['title'], 'url' => $row['url'], 'price' => $row['price'],
                    'available' => $row['available'], 'observed_at' => $now, 'updated_at' => $now,
                ]);
                $history = DB::table('discovery_samples')->where('offer_id', $offer->id)
                    ->where('day', '>=', $now->copy()->subDays(30)->toDateString())
                    ->where('day', '<', $now->toDateString())->pluck('price')->map(fn ($p) => (float) $p)->all();
                if ($row['available'] && (float) $row['price'] > 0) {
                    DB::table('discovery_samples')->updateOrInsert(
                        ['offer_id' => $offer->id, 'day' => $now->toDateString()], ['price' => $row['price']]
                    );
                }

                $matches = 0;
                foreach (Watch::active()->orderBy('id')->lockForUpdate()->get() as $watch) {
                    $reason = app(DealMatcher::class)->reason($watch, $row, $history, $source);
                    $key = ['watch_id' => $watch->id, 'offer_id' => $offer->id];
                    if ($reason === null) {
                        DB::table('discovery_matches')->where($key)->delete();

                        continue;
                    }
                    $previous = DB::table('discovery_matches')->where($key)->first();
                    DB::table('discovery_matches')->updateOrInsert($key, [
                        'reason' => $reason, 'price' => $row['price'],
                        'expires_at' => $now->copy()->addMinutes(config('discovery.ttl_minutes')),
                        'created_at' => $now, 'updated_at' => $now,
                    ]);
                    // Only first matches or further price drops create an alert.
                    // Same-price refreshes extend freshness without spamming the inbox.
                    if ((! $previous || (float) $row['price'] < (float) $previous->price) && ! $watch->isOnCooldown()) {
                        $user = $watch->user;
                        if ($user instanceof User && in_array('app', $watch->channels(), true)) {
                            $user->notify(new DiscoveryDealNotification($row, $reason, $watch->id));
                            $watch->update(['last_alerted_at' => $now]);
                        }
                    }
                    $matches++;
                }

                return $matches;
            });
        }

        return $count;
    }
}
