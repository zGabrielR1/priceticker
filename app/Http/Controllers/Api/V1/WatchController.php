<?php

namespace App\Http\Controllers\Api\V1;

use App\Enums\WatchType;
use App\Models\Watch;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class WatchController
{
    public function index(Request $request): JsonResponse
    {
        $watches = Watch::query()
            ->where('user_id', $request->user()->id)
            ->latest()
            ->get();

        return response()->json(['data' => $watches]);
    }

    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'type' => ['required', 'in:'.implode(',', WatchType::values())],
            'name' => ['required', 'string', 'max:255'],
            'config' => ['nullable', 'array'],
            'rules' => ['nullable', 'array'],
            'is_active' => ['sometimes', 'boolean'],
            ...$this->discoveryRules(),
        ]);
        // Nested validation must not discard existing type-specific JSON fields.
        $data = array_replace($data, $request->only(['config', 'rules']));

        $watch = Watch::create(array_merge($data, [
            'user_id' => $request->user()->id,
        ]));

        return response()->json(['data' => $watch], 201);
    }

    public function show(Request $request, Watch $watch): JsonResponse
    {
        $this->authorize($request, $watch);

        return response()->json(['data' => $watch]);
    }

    public function update(Request $request, Watch $watch): JsonResponse
    {
        $this->authorize($request, $watch);

        $data = $request->validate([
            'type' => ['sometimes', 'in:'.implode(',', WatchType::values())],
            'name' => ['sometimes', 'string', 'max:255'],
            'config' => ['nullable', 'array'],
            'rules' => ['nullable', 'array'],
            'is_active' => ['sometimes', 'boolean'],
            ...$this->discoveryRules(),
        ]);
        // Nested validation must not discard existing type-specific JSON fields.
        $data = array_replace($data, $request->only(['config', 'rules']));

        $watch->update($data);

        return response()->json(['data' => $watch->fresh()]);
    }

    public function destroy(Request $request, Watch $watch): JsonResponse
    {
        $this->authorize($request, $watch);
        $watch->delete();

        return response()->json(['message' => 'Deleted'], 204);
    }

    private function discoveryRules(): array
    {
        return [
            'config.keywords' => ['sometimes', 'array', 'max:20'],
            'config.keywords.*' => ['required', 'string', 'max:120'],
            'config.keyword_mode' => ['sometimes', 'in:any,all'],
            'config.exclude_keywords' => ['sometimes', 'array', 'max:20'],
            'config.exclude_keywords.*' => ['required', 'string', 'max:120'],
            'rules.max_price' => ['sometimes', 'nullable', 'numeric', 'min:0.01', 'max:9999999999.99'],
            'rules.min_pct_below_30d' => ['sometimes', 'nullable', 'numeric', 'min:0', 'max:100'],
            'rules.min_pct_below_90d' => ['sometimes', 'nullable', 'numeric', 'min:0', 'max:100'],
            'rules.record_low_only' => ['sometimes', 'boolean'],
            'rules.store_allowlist' => ['sometimes', 'array', 'max:30'],
            'rules.store_allowlist.*' => ['required', 'string', 'max:80'],
            'rules.cooldown_minutes' => ['sometimes', 'integer', 'min:0', 'max:10080'],
        ];
    }

    protected function authorize(Request $request, Watch $watch): void
    {
        abort_unless($watch->user_id === $request->user()->id, 403);
    }
}
