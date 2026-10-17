<?php

namespace Database\Factories;

use App\Enums\WatchType;
use App\Models\User;
use App\Models\Watch;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Watch>
 */
class WatchFactory extends Factory
{
    protected $model = Watch::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'type' => WatchType::Product->value,
            'name' => $this->faker->words(3, true),
            'config' => [],
            'rules' => [],
            'is_active' => true,
        ];
    }
}
