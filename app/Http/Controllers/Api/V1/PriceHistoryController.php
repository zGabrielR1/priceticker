<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PriceHistoryController
{
    public function index(Request $request, Product $product): JsonResponse
    {
        abort_unless($product->user_id === $request->user()->id, 403);

        $prices = $product->prices()
            ->latest('created_at')
            ->limit((int) $request->query('limit', 100))
            ->get();

        return response()->json(['data' => $prices]);
    }
}
