<?php

namespace App\Notifications\Channels;

use App\Models\Device;
use App\Models\User;
use App\Services\FcmService;
use Illuminate\Notifications\Notification;

class FcmChannel
{
    public function __construct(protected FcmService $fcm) {}

    public function send($notifiable, Notification $notification): void
    {
        if (! method_exists($notification, 'toFcm')) {
            return;
        }

        $message = $notification->toFcm($notifiable);

        if (! is_array($message)) {
            return;
        }

        $title = (string) ($message['title'] ?? '');
        $body = (string) ($message['body'] ?? '');
        $data = (array) ($message['data'] ?? []);

        if ($notifiable instanceof User) {
            $tokens = Device::where('user_id', $notifiable->id)->pluck('fcm_token')->all();
        } elseif (is_object($notifiable) && method_exists($notifiable, 'getKey')) {
            $tokens = Device::where('user_id', $notifiable->getKey())->pluck('fcm_token')->all();
        } else {
            $tokens = [];
        }

        if (empty($tokens)) {
            return;
        }

        $this->fcm->sendToMany($tokens, $title, $body, $data);
    }
}
