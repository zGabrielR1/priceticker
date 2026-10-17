<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

/**
 * Send push notifications via Firebase Cloud Messaging (FCM).
 * Fail-safe: when no server key is configured, sends are no-ops.
 * Transport is injectable for tests.
 */
class FcmService
{
    protected ?string $serverKey;

    protected string $endpoint;

    /** @var callable|null */
    protected $transport;

    public function __construct(?string $serverKey = null, ?string $endpoint = null, ?callable $transport = null)
    {
        $this->serverKey = $serverKey ?? config('services.fcm.server_key');
        $this->endpoint = $endpoint ?? config('services.fcm.endpoint', 'https://fcm.googleapis.com/fcm/send');
        $this->transport = $transport;
    }

    public static function new(): self
    {
        return resolve(static::class);
    }

    public function isConfigured(): bool
    {
        return filled($this->serverKey);
    }

    /**
     * @return bool true if accepted by FCM (or no-op when unconfigured)
     */
    public function send(string $token, string $title, string $body = '', array $data = []): bool
    {
        if (! $this->isConfigured()) {
            return false;
        }

        $payload = [
            'to' => $token,
            'notification' => [
                'title' => $title,
                'body' => $body,
            ],
            'data' => $data,
        ];

        try {
            if ($this->transport) {
                $response = ($this->transport)($this->endpoint, $payload, $this->serverKey);

                return (bool) ($response['success'] ?? false);
            }

            $response = Http::withHeaders([
                'Authorization' => 'key='.$this->serverKey,
                'Content-Type' => 'application/json',
            ])->post($this->endpoint, $payload);

            return $response->successful();
        } catch (\Throwable $e) {
            return false;
        }
    }

    public function sendToMany(array $tokens, string $title, string $body = '', array $data = []): int
    {
        $sent = 0;
        foreach ($tokens as $token) {
            if ($this->send($token, $title, $body, $data)) {
                $sent++;
            }
        }

        return $sent;
    }
}
