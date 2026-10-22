<?php

namespace Tests\Feature\Api\V1;

use App\Models\Product;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class MobileApiTest extends TestCase
{
    use RefreshDatabase;

    private User $user;

    private string $token;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create(['password' => bcrypt('secret')]);
        $this->token = $this->user->createToken('test')->plainTextToken;
    }

    private function authHeaders(): array
    {
        return ['Authorization' => 'Bearer '.$this->token];
    }

    public function test_token_issuance(): void
    {
        $response = $this->postJson('/api/v1/auth/token', [
            'email' => $this->user->email,
            'password' => 'secret',
        ]);
        $response->assertSuccessful()->assertJsonStructure(['token', 'token_type']);
    }

    public function test_token_rejects_bad_credentials(): void
    {
        $response = $this->postJson('/api/v1/auth/token', [
            'email' => $this->user->email,
            'password' => 'wrong',
        ]);
        $response->assertStatus(422);
    }

    public function test_watch_crud(): void
    {
        $create = $this->postJson('/api/v1/watches', [
            'type' => 'product',
            'name' => 'My watch',
            'rules' => ['max_price' => 100],
        ], $this->authHeaders());
        $create->assertStatus(201);
        $id = $create->json('data.id');

        $this->getJson('/api/v1/watches', $this->authHeaders())
            ->assertSuccessful()
            ->assertJsonCount(1, 'data');

        $this->getJson("/api/v1/watches/{$id}", $this->authHeaders())
            ->assertSuccessful();

        $this->putJson("/api/v1/watches/{$id}", ['name' => 'Renamed'], $this->authHeaders())
            ->assertSuccessful()
            ->assertJsonPath('data.name', 'Renamed');

        $this->deleteJson("/api/v1/watches/{$id}", [], $this->authHeaders())
            ->assertStatus(204);
    }

    public function test_watch_requires_auth(): void
    {
        $this->getJson('/api/v1/watches')->assertStatus(401);
    }

    public function test_device_registration(): void
    {
        $response = $this->postJson('/api/v1/devices', [
            'fcm_token' => 'tok123',
            'platform' => 'android',
        ], $this->authHeaders());
        $response->assertStatus(201);
        $this->assertDatabaseHas('devices', ['fcm_token' => 'tok123', 'user_id' => $this->user->id]);
    }

    public function test_alert_feed(): void
    {
        $this->getJson('/api/v1/alerts', $this->authHeaders())->assertSuccessful();
    }

    public function test_price_history(): void
    {
        $product = Product::factory()->create(['user_id' => $this->user->id]);
        $this->getJson("/api/v1/products/{$product->id}/prices", $this->authHeaders())
            ->assertSuccessful();
    }
}
