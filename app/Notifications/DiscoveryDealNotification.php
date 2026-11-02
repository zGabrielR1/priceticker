<?php

namespace App\Notifications;

use App\Enums\NotificationMethods;
use App\Models\User;
use App\Services\Helpers\NotificationsHelper;
use Illuminate\Notifications\Notification;

class DiscoveryDealNotification extends Notification
{
    public function __construct(private array $offer, private string $reason, private int $watchId, private ?string $observedAt = null) {}

    public function via(object $notifiable): array
    {
        // The per-watch 'app' channel gate already ran before dispatch. The
        // database inbox is always written; push is added only when the app-level
        // FCM service is enabled, so discovery stays DB-only until a host configures it.
        $channels = ['database'];

        if ($notifiable instanceof User && NotificationsHelper::isEnabled(NotificationMethods::Fcm)) {
            $channels[] = NotificationMethods::Fcm->getChannel();
        }

        return $channels;
    }

    public function toArray(object $notifiable): array
    {
        return [
            'title' => $this->title(),
            'body' => $this->body(),
            'url' => $this->offer['url'],
            'watch_id' => $this->watchId,
            'observed_at' => $this->observedAt(),
        ];
    }

    public function toFcm(User $notifiable): array
    {
        return [
            'title' => $this->title(),
            'body' => $this->body(),
            // FCM data values must be strings; keys mirror the inbox payload so
            // the mobile client can deep-link without a second contract.
            'data' => [
                'type' => 'discovery_deal',
                'watch_id' => (string) $this->watchId,
                'url' => (string) $this->offer['url'],
                'observed_at' => (string) $this->observedAt(),
            ],
        ];
    }

    private function title(): string
    {
        return 'Deal found: '.$this->offer['title'];
    }

    private function body(): string
    {
        return 'R$ '.number_format((float) $this->offer['price'], 2, ',', '.').' · '.$this->reason;
    }

    private function observedAt(): string
    {
        return $this->observedAt ?? now()->toIso8601String();
    }
}
