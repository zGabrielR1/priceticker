<?php

namespace App\Models;

use App\Enums\WatchType;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Builder as EloquentBuilder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Arr;

/**
 * @property ?Carbon $last_alerted_at
 */
class Watch extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'type',
        'name',
        'config',
        'rules',
        'is_active',
        'last_alerted_at',
    ];

    protected function casts(): array
    {
        return [
            'type' => WatchType::class,
            'config' => 'array',
            'rules' => 'array',
            'is_active' => 'boolean',
            'last_alerted_at' => 'datetime',
        ];
    }

    /***************************************************
     * Relationships.
     **************************************************/

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /***************************************************
     * Scopes.
     **************************************************/

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('is_active', true);
    }

    public function scopeOfType(Builder $query, WatchType|string $type): Builder
    {
        $value = $type instanceof WatchType ? $type->value : $type;

        return $query->where('type', $value);
    }

    public function scopeCurrentUser(EloquentBuilder $query): EloquentBuilder
    {
        return $query->where('user_id', auth()->id());
    }

    /***************************************************
     * Rule helpers (explainable, safe defaults).
     **************************************************/

    public function rule(string $key, mixed $default = null): mixed
    {
        return Arr::get($this->rules ?? [], $key, $default);
    }

    public function maxPrice(): ?float
    {
        $value = $this->rule('max_price');

        return $value === null ? null : (float) $value;
    }

    public function minPctBelow30d(): ?float
    {
        $value = $this->rule('min_pct_below_30d');

        return $value === null ? null : (float) $value;
    }

    public function minPctBelow90d(): ?float
    {
        $value = $this->rule('min_pct_below_90d');

        return $value === null ? null : (float) $value;
    }

    public function recordLowOnly(): bool
    {
        return (bool) $this->rule('record_low_only', false);
    }

    public function storeAllowlist(): array
    {
        return (array) $this->rule('store_allowlist', []);
    }

    public function channels(): array
    {
        return (array) $this->rule('channels', ['app']);
    }

    public function cooldownMinutes(): int
    {
        return (int) $this->rule('cooldown_minutes', 60);
    }

    public function isOnCooldown(): bool
    {
        if (! $this->last_alerted_at) {
            return false;
        }

        return $this->last_alerted_at->copy()->addMinutes($this->cooldownMinutes())->isFuture();
    }

    /***************************************************
     * Config helpers.
     **************************************************/

    public function configValue(string $key, mixed $default = null): mixed
    {
        return Arr::get($this->config ?? [], $key, $default);
    }
}
