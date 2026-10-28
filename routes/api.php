<?php

use App\Enums\ApiAbility;
use App\Http\Controllers\Api\ClientConfigController;
use App\Http\Controllers\Api\MetaExtractionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user()->only(['id', 'name', 'email']);
})->middleware(['auth:sanctum', 'ability:'.ApiAbility::UserDetail->value])->name('api.user');

Route::post('/meta-extraction', MetaExtractionController::class)
    ->middleware(['auth:sanctum', 'ability:'.ApiAbility::MetaExtractionExtract->value, 'throttle:api'])
    ->name('api.meta-extraction');

Route::get('/client-config', ClientConfigController::class)
    ->middleware(['auth:sanctum', 'ability:'.ApiAbility::ClientConfigRead->value, 'throttle:api'])
    ->name('api.client-config');

// Versioned mobile API (v1). Every authenticated route names the ability it
// needs: a token minted for one client must not be able to drive another
// surface. Issued tokens carry '*' today, so the mobile app keeps working.
Route::prefix('v1')->group(function () {
    Route::post('/auth/token', [\App\Http\Controllers\Api\V1\AuthController::class, 'token'])
        ->middleware('throttle:auth')->name('api.v1.auth.token');
    Route::post('/auth/revoke', [\App\Http\Controllers\Api\V1\AuthController::class, 'revoke'])
        ->middleware(['auth:sanctum', 'ability:'.ApiAbility::AccountManage->value])
        ->name('api.v1.auth.revoke');

    Route::middleware(['auth:sanctum', 'throttle:api'])->group(function () {
        Route::get('/watches', [\App\Http\Controllers\Api\V1\WatchController::class, 'index'])
            ->middleware('ability:'.ApiAbility::WatchesRead->value)->name('watches.index');
        Route::post('/watches', [\App\Http\Controllers\Api\V1\WatchController::class, 'store'])
            ->middleware('ability:'.ApiAbility::WatchesWrite->value)->name('watches.store');
        Route::get('/watches/{watch}', [\App\Http\Controllers\Api\V1\WatchController::class, 'show'])
            ->middleware('ability:'.ApiAbility::WatchesRead->value)->name('watches.show');
        Route::put('/watches/{watch}', [\App\Http\Controllers\Api\V1\WatchController::class, 'update'])
            ->middleware('ability:'.ApiAbility::WatchesWrite->value)->name('watches.update');
        Route::delete('/watches/{watch}', [\App\Http\Controllers\Api\V1\WatchController::class, 'destroy'])
            ->middleware('ability:'.ApiAbility::WatchesWrite->value)->name('watches.destroy');

        Route::post('/devices', [\App\Http\Controllers\Api\V1\DeviceController::class, 'store'])
            ->middleware('ability:'.ApiAbility::DevicesWrite->value)->name('api.v1.devices.store');
        Route::delete('/devices/{device}', [\App\Http\Controllers\Api\V1\DeviceController::class, 'destroy'])
            ->middleware('ability:'.ApiAbility::DevicesWrite->value)->name('api.v1.devices.destroy');

        Route::get('/products/{product}/prices', [\App\Http\Controllers\Api\V1\PriceHistoryController::class, 'index'])
            ->middleware('ability:'.ApiAbility::PricesRead->value)->name('api.v1.products.prices');

        Route::get('/alerts', [\App\Http\Controllers\Api\V1\AlertController::class, 'index'])
            ->middleware('ability:'.ApiAbility::AlertsRead->value)->name('api.v1.alerts.index');
        Route::post('/alerts/{id}/read', [\App\Http\Controllers\Api\V1\AlertController::class, 'markRead'])
            ->middleware('ability:'.ApiAbility::AlertsWrite->value)->name('api.v1.alerts.read');
    });
});

// Automation uses source-bound HMAC, not a mobile token. No URLs are fetched here.
Route::post('/v1/discovery/{source}/events', [\App\Http\Controllers\Api\V1\DiscoveryController::class, 'ingest'])
    ->middleware('throttle:api')->name('api.v1.discovery.ingest');
Route::get('/v1/deals', [\App\Http\Controllers\Api\V1\DiscoveryController::class, 'index'])
    ->middleware(['auth:sanctum', 'ability:'.ApiAbility::WatchesRead->value, 'throttle:api'])->name('api.v1.deals');
Route::get('/v1/discovery/sources', [\App\Http\Controllers\Api\V1\DiscoveryController::class, 'sources'])
    ->middleware(['auth:sanctum', 'ability:'.ApiAbility::WatchesRead->value, 'throttle:api'])->name('api.v1.discovery.sources');
