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
        ]);

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
        ]);

        $watch->update($data);

        return response()->json(['data' => $watch->fresh()]);
    }

    public function destroy(Request $request, Watch $watch): JsonResponse
    {
        $this->authorize($request, $watch);
        $watch->delete();

        return response()->json(['message' => 'Deleted'], 204);
    }

    protected function authorize(Request $request, Watch $watch): void
    {
        abort_unless($watch->user_id === $request->user()->id, 403);
    }
}
