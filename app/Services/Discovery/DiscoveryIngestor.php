<?php

namespace App\Services\Discovery;

use App\Models\User;
use App\Models\Watch;
use App\Notifications\DiscoveryDealNotification;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class DiscoveryIngestor
{
    public function ingest(string $source, array $rows, ?CarbonImmutable $observedAt = null): int
    {
        $observedAt = ($observedAt ?? CarbonImmutable::now())->setTimezone(config('app.timezone'));
        if ($observedAt->isBefore(now()->subMinutes(config('discovery.ttl_minutes'))) || $observedAt->isAfter(now()->addSeconds(30))) {
            throw ValidationException::withMessages(['observed_at' => 'Observation must be recent and cannot be in the future.']);
        }
        $count = 0;
        foreach ($rows as $row) {
            $count += DB::transaction(function () use ($source, $row, $observedAt) {
                $now = now();
                $identity = hash('sha256', $source.':'.$row['sku']);
                $inserted = DB::table('discovery_offers')->insertOrIgnore([
                    'identity' => $identity, 'source' => $source, 'sku' => $row['sku'],
                    'title' => $row['title'], 'url' => $row['url'], 'price' => $row['price'],
                    'available' => $row['available'], 'observed_at' => $observedAt,
                    'source_observed_at' => $observedAt->format('Y-m-d H:i:s.u'),
                    'created_at' => $now, 'updated_at' => $now,
                ]);
                $offer = DB::table('discovery_offers')->where('identity', $identity)->lockForUpdate()->first();
                $watermark = $offer->source_observed_at ?? $offer->observed_at;
                if (! $inserted && CarbonImmutable::parse($watermark)->greaterThanOrEqualTo($observedAt)) {
                    return 0; // An exact retry or older snapshot cannot rewind the offer or refresh its expiry.
                }
                DB::table('discovery_offers')->where('id', $offer->id)->update([
                    'title' => $row['title'], 'url' => $row['url'], 'price' => $row['price'],
                    'available' => $row['available'], 'observed_at' => $observedAt,
                    'source_observed_at' => $observedAt->format('Y-m-d H:i:s.u'), 'updated_at' => $now,
                ]);
                $history = DB::table('discovery_samples')->where('offer_id', $offer->id)
                    ->where('day', '>=', $observedAt->subDays(30)->toDateString())
                    ->where('day', '<', $observedAt->toDateString())->pluck('price')->map(fn ($p) => (float) $p)->all();
                if ($row['available'] && (float) $row['price'] > 0) {
                    DB::table('discovery_samples')->updateOrInsert(
                        ['offer_id' => $offer->id, 'day' => $observedAt->toDateString()], ['price' => $row['price']]
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
                        'expires_at' => $observedAt->addMinutes(config('discovery.ttl_minutes')),
                        'created_at' => $now, 'updated_at' => $now,
                    ]);
                    // Only first matches or further price drops create an alert.
                    // Same-price refreshes extend freshness without spamming the inbox.
                    if ((! $previous || (float) $row['price'] < (float) $previous->price) && ! $watch->isOnCooldown()) {
                        $user = $watch->user;
                        if ($user instanceof User && in_array('app', $watch->channels(), true)) {
                            $user->notify(new DiscoveryDealNotification($row, $reason, $watch->id, $observedAt->toIso8601String()));
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
