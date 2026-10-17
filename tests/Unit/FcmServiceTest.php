<?php

namespace Tests\Unit;

use App\Services\FcmService;
use Tests\TestCase;

class FcmServiceTest extends TestCase
{
    public function test_unconfigured_is_noop(): void
    {
        $svc = new FcmService(null);
        $this->assertFalse($svc->isConfigured());
        $this->assertFalse($svc->send('tok', 'title', 'body'));
    }

    public function test_send_success_via_transport(): void
    {
        $transport = function (string $endpoint, array $payload, string $key): array {
            $this->assertStringContainsString('fcm.googleapis.com', $endpoint);
            $this->assertSame('key123', $key);
            $this->assertSame('tok', $payload['to']);

            return ['success' => true];
        };

        $svc = new FcmService('key123', 'https://fcm.googleapis.com/fcm/send', $transport);
        $this->assertTrue($svc->isConfigured());
        $this->assertTrue($svc->send('tok', 'title', 'body', ['foo' => 'bar']));
    }

    public function test_send_failure_returns_false(): void
    {
        $transport = function (string $endpoint, array $payload, string $key): array {
            throw new \RuntimeException('boom');
        };

        $svc = new FcmService('key123', 'https://fcm.googleapis.com/fcm/send', $transport);
        $this->assertFalse($svc->send('tok', 'title'));
    }

    public function test_send_to_many_counts(): void
    {
        $transport = fn (string $e, array $p, string $k): array => ['success' => true];
        $svc = new FcmService('key123', 'https://fcm.googleapis.com/fcm/send', $transport);
        $this->assertSame(2, $svc->sendToMany(['a', 'b'], 't'));
    }
}
