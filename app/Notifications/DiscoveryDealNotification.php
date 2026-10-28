<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;

class DiscoveryDealNotification extends Notification
{
    public function __construct(private array $offer, private string $reason, private int $watchId) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        return [
            'title' => 'Deal found: '.$this->offer['title'],
            'body' => 'R$ '.number_format((float) $this->offer['price'], 2, ',', '.').' · '.$this->reason,
            'url' => $this->offer['url'],
            'watch_id' => $this->watchId,
            'observed_at' => now()->toIso8601String(),
        ];
    }
}
