<?php

namespace App\Filament\Resources\WatchResource\Pages;

use App\Filament\Resources\WatchResource;
use Filament\Resources\Pages\CreateRecord;

class CreateWatch extends CreateRecord
{
    protected static string $resource = WatchResource::class;

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        return array_merge($data, [
            'user_id' => auth()->id(),
        ]);
    }
}
