<?php

use App\Enums\WatchType;
use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('watches', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(User::class)->nullable()->constrained()->nullOnDelete();
            $table->string('type')->default(WatchType::Product->value);
            $table->string('name');
            $table->json('config')->nullable();   // type-specific payload (urls, keywords, filters, top_n, ...)
            $table->json('rules')->nullable();    // max_price, pct_below_30d, pct_below_90d, record_low_only, store_allowlist, channels, cooldown_minutes
            $table->boolean('is_active')->default(true);
            $table->timestamp('last_alerted_at')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'type']);
            $table->index(['is_active', 'type']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('watches');
    }
};
