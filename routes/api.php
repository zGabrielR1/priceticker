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

// Versioned mobile API (v1)
Route::prefix('v1')->group(function () {
    Route::post('/auth/token', [\App\Http\Controllers\Api\V1\AuthController::class, 'token'])
        ->middleware('throttle:auth')->name('api.v1.auth.token');
    Route::post('/auth/revoke', [\App\Http\Controllers\Api\V1\AuthController::class, 'revoke'])
        ->middleware('auth:sanctum')->name('api.v1.auth.revoke');

    Route::middleware(['auth:sanctum', 'throttle:api'])->group(function () {
        Route::apiResource('watches', \App\Http\Controllers\Api\V1\WatchController::class);
        Route::post('/devices', [\App\Http\Controllers\Api\V1\DeviceController::class, 'store'])->name('api.v1.devices.store');
        Route::delete('/devices/{device}', [\App\Http\Controllers\Api\V1\DeviceController::class, 'destroy'])->name('api.v1.devices.destroy');
        Route::get('/products/{product}/prices', [\App\Http\Controllers\Api\V1\PriceHistoryController::class, 'index'])->name('api.v1.products.prices');
        Route::get('/alerts', [\App\Http\Controllers\Api\V1\AlertController::class, 'index'])->name('api.v1.alerts.index');
        Route::post('/alerts/{id}/read', [\App\Http\Controllers\Api\V1\AlertController::class, 'markRead'])->name('api.v1.alerts.read');
    });
});
