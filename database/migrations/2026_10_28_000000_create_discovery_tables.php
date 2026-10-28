<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('discovery_offers', function (Blueprint $table) {
            $table->id();
            $table->string('identity', 64)->unique();
            $table->string('source');
            $table->string('sku');
            $table->string('title');
            $table->text('url');
            $table->decimal('price', 12, 2);
            $table->boolean('available');
            $table->timestamp('observed_at');
            $table->timestamps();
        });
        Schema::create('discovery_samples', function (Blueprint $table) {
            $table->id();
            $table->foreignId('offer_id')->constrained('discovery_offers')->cascadeOnDelete();
            $table->date('day');
            $table->decimal('price', 12, 2);
            $table->unique(['offer_id', 'day']);
        });
        Schema::create('discovery_matches', function (Blueprint $table) {
            $table->id();
            $table->foreignId('watch_id')->constrained()->cascadeOnDelete();
            $table->foreignId('offer_id')->constrained('discovery_offers')->cascadeOnDelete();
            $table->string('reason');
            $table->decimal('price', 12, 2);
            $table->timestamp('expires_at')->index();
            $table->timestamps();
            $table->unique(['watch_id', 'offer_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('discovery_matches');
        Schema::dropIfExists('discovery_samples');
        Schema::dropIfExists('discovery_offers');
    }
};
