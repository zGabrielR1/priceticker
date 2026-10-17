<?php

namespace App\Http\Controllers\Api\V1;

use App\Models\Device;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class DeviceController
{
    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'fcm_token' => ['required', 'string', 'max:512'],
            'platform' => ['sometimes', 'string', 'max:32'],
            'device_id' => ['nullable', 'string', 'max:255'],
        ]);

        $device = Device::updateOrCreate(
            ['fcm_token' => $data['fcm_token']],
            array_merge($data, [
                'user_id' => $request->user()->id,
                'last_seen_at' => now(),
            ])
        );

        return response()->json(['data' => $device], 201);
    }

    public function destroy(Request $request, Device $device): JsonResponse
    {
        abort_unless($device->user_id === $request->user()->id, 403);
        $device->delete();

        return response()->json(['message' => 'Deleted'], 204);
    }
}
