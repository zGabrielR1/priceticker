<?php

namespace Tests\Feature\Filament;

use App\Enums\WatchType;
use App\Filament\Resources\WatchResource;
use App\Models\User;
use App\Models\Watch;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Livewire\Livewire;
use Tests\TestCase;

class WatchResourceTest extends TestCase
{
    use RefreshDatabase;

    protected User $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create();
    }

    public function test_can_render_watch_index_page()
    {
        $this->actingAs($this->user);
        $this->get(WatchResource::getUrl('index'))->assertSuccessful();
    }

    public function test_can_render_create_watch_page()
    {
        $this->actingAs($this->user);
        $this->get(WatchResource::getUrl('create'))->assertSuccessful();
    }

    public function test_can_create_watch()
    {
        $this->actingAs($this->user);

        $newData = [
            'type' => WatchType::Product->value,
            'name' => 'My product watch',
            'is_active' => true,
            'config' => [],
            'rules' => [
                'max_price' => 100,
                'cooldown_minutes' => 60,
            ],
        ];

        Livewire::test(WatchResource\Pages\CreateWatch::class)
            ->fillForm($newData)
            ->call('create')
            ->assertHasNoFormErrors();

        $this->assertDatabaseHas('watches', [
            'name' => 'My product watch',
            'type' => WatchType::Product->value,
            'user_id' => $this->user->id,
        ]);
    }

    public function test_can_create_all_watch_types()
    {
        $this->actingAs($this->user);

        foreach (WatchType::cases() as $type) {
            Livewire::test(WatchResource\Pages\CreateWatch::class)
                ->fillForm([
                    'type' => $type->value,
                    'name' => 'Watch '.$type->value,
                    'is_active' => true,
                ])
                ->call('create')
                ->assertHasNoFormErrors();
        }

        $this->assertDatabaseCount('watches', count(WatchType::cases()));
    }

    public function test_watch_rules_helpers()
    {
        $watch = Watch::factory()->make([
            'type' => WatchType::Brand->value,
            'rules' => [
                'max_price' => 50.5,
                'min_pct_below_30d' => 10,
                'min_pct_below_90d' => 15,
                'record_low_only' => true,
                'store_allowlist' => ['kabum.com.br', 'pichau.com.br'],
                'channels' => ['ntfy', 'app'],
                'cooldown_minutes' => 30,
            ],
            'config' => ['brand' => 'Logitech', 'keywords' => ['mouse', 'teclado']],
        ]);

        $this->assertSame(50.5, $watch->maxPrice());
        $this->assertSame(10.0, $watch->minPctBelow30d());
        $this->assertSame(15.0, $watch->minPctBelow90d());
        $this->assertTrue($watch->recordLowOnly());
        $this->assertSame(['kabum.com.br', 'pichau.com.br'], $watch->storeAllowlist());
        $this->assertSame(['ntfy', 'app'], $watch->channels());
        $this->assertSame(30, $watch->cooldownMinutes());
        $this->assertSame('Logitech', $watch->configValue('brand'));
    }

    public function test_watch_cooldown()
    {
        $watch = Watch::factory()->make([
            'last_alerted_at' => now(),
            'rules' => ['cooldown_minutes' => 60],
        ]);

        $this->assertTrue($watch->isOnCooldown());

        $watch->last_alerted_at = now()->subHours(2);
        $this->assertFalse($watch->isOnCooldown());
    }
}
