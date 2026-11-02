<?php

namespace Tests\Unit\Notifications\Channels;

use App\Enums\NotificationMethods;
use App\Models\Device;
use App\Models\Product;
use App\Models\User;
use App\Notifications\Channels\FcmChannel;
use App\Notifications\PriceAlertNotification;
use App\Notifications\StockAlertNotification;
use App\Services\FcmService;
use App\Services\Helpers\NotificationsHelper;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FcmChannelTest extends TestCase
{
    use RefreshDatabase;

    protected User $user;

    /** @var array<int, array<string, mixed>> */
    protected array $sent = [];

    protected function setUp(): void
    {
        parent::setUp();

        NotificationsHelper::setSetting(NotificationMethods::Fcm, value: ['enabled' => true]);

        $this->user = User::factory()->createOne();
        Device::create(['user_id' => $this->user->id, 'fcm_token' => 'tok-1', 'platform' => 'android', 'device_id' => 'dev-1']);
    }

    protected function fcmService(): FcmService
    {
        return new FcmService('server-key', 'https://fcm.invalid', function ($endpoint, $payload, $key) {
            $this->sent[] = $payload;

            return ['success' => true];
        });
    }

    protected function trackedUrl(): mixed
    {
        return Product::factory()->addUrlsAndPrices()->create(['title' => 'Notif product'])->urls()->first();
    }

    public function test_price_alert_pushes_with_deep_link_data(): void
    {
        $url = $this->trackedUrl();
        (new FcmChannel($this->fcmService()))->send($this->user, new PriceAlertNotification($url));

        $this->assertCount(1, $this->sent);
        $this->assertSame('tok-1', $this->sent[0]['to']);
        $this->assertStringStartsWith('Price drop:', $this->sent[0]['notification']['title']);
        $this->assertSame('price_drop', $this->sent[0]['data']['type']);
        $this->assertSame($url->buy_url, $this->sent[0]['data']['url']);
        $this->assertSame((string) $url->id, $this->sent[0]['data']['url_id']);
    }

    public function test_stock_alert_pushes_as_back_in_stock(): void
    {
        $url = $this->trackedUrl();
        (new FcmChannel($this->fcmService()))->send($this->user, new StockAlertNotification($url));

        $this->assertCount(1, $this->sent);
        $this->assertStringStartsWith('Back in stock:', $this->sent[0]['notification']['title']);
        $this->assertSame('back_in_stock', $this->sent[0]['data']['type']);
    }

    public function test_no_push_when_the_user_has_no_registered_devices(): void
    {
        (new FcmChannel($this->fcmService()))->send(User::factory()->createOne(), new PriceAlertNotification($this->trackedUrl()));

        $this->assertEmpty($this->sent);
    }

    public function test_fcm_channel_is_only_selected_while_the_service_is_enabled(): void
    {
        $notification = new PriceAlertNotification($this->trackedUrl());
        $this->assertContains(FcmChannel::class, $notification->via($this->user));

        NotificationsHelper::setSetting(NotificationMethods::Fcm, value: ['enabled' => false]);
        $this->assertNotContains(FcmChannel::class, $notification->via($this->user));
    }
}
