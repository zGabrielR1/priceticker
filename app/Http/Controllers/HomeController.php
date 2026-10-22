<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;

class HomeController extends Controller
{
    /**
     * Send the site root to the admin dashboard.
     *
     * A controller instead of a route closure: closures cannot be serialized
     * by `php artisan route:cache`, which the container runs on every boot.
     */
    public function __invoke(): RedirectResponse
    {
        return redirect()->route('filament.admin.pages.home-dashboard');
    }
}
