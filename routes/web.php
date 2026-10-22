<?php

use App\Http\Controllers\HomeController;
use App\Http\Controllers\ManifestController;
use App\Http\Controllers\ProductController;
use Illuminate\Support\Facades\Route;

Route::get('manifest.json', ManifestController::class);

Route::get('/', HomeController::class)->name('home');

Route::prefix('admin/products')->name('filament.admin.resources.products.')
    ->group(function () {
        Route::post('/{product}/fetch', [ProductController::class, 'fetch'])
            ->name('fetch');
    });
