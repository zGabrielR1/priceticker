<?php

namespace App\Console\Commands;

use App\Enums\Role;
use App\Models\User;
use Exception;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class InitDatabase extends Command
{
    const COMMAND = 'buddy:init-db';

    /**
     * The name and signature of the console command.
     */
    protected $signature = self::COMMAND;

    /**
     * The console command description.
     */
    protected $description = 'Initialize the database';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        try {
            DB::connection()->getPdo();
            $this->ensureSchema();
            $hasTables = Schema::hasTable('migrations');
        } catch (Exception $e) {
            $this->getOutput()->error('Database connection failed, check environment settings');
            $this->getOutput()->error($e->getMessage());

            return self::FAILURE;
        }

        if ($hasTables) {
            $this->getOutput()->info('Database already initialized');

            $this->components->task('Applying database updates', function () {
                $this->callSilent('migrate', ['--force' => true]);
            });

            // @todo sync stores?
        } else {
            $this->getOutput()->info('Database exists, but not initialized');

            $this->components->task('Setting up the database', fn () => $this
                ->callSilent('migrate:fresh', ['--force' => true])
            );

            // @phpstan-ignore-next-line
            $storeCountry = env('DEFAULT_STORES_COUNTRY', 'all');
            $this->components->task('Creating stores for country: '.$storeCountry, fn () => $this
                ->callSilent(CreateStores::COMMAND, ['country' => $storeCountry])
            );

            // @phpstan-ignore-next-line
            $email = env('APP_USER_EMAIL');
            // @phpstan-ignore-next-line
            $pass = env('APP_USER_PASSWORD');
            if ($email && $pass) {
                // Never print the password: first-boot logs are often kept
                // longer and read by more people than the secret store.
                $this->line('Creating the initial admin user: '.$email);
                // @phpstan-ignore-next-line
                $name = env('APP_USER_NAME', 'Admin');
                $this->components->task('Creating the default user', fn () => $this
                    ->createDefaultUser($name, $email, $pass)->exists
                );
            }
        }

        $this->getOutput()->success('Database init complete');

        return self::SUCCESS;
    }

    /**
     * Postgres needs the schema to exist before the first migration. Managed
     * Postgres (Supabase, Neon, Render) usually only ships `public`, and a
     * shared project may already use it, so a dedicated schema is the safe
     * way to keep two applications in one database. Laravel sets the
     * connection's search_path before this runs; creating the schema is the
     * one thing it cannot do for itself.
     */
    protected function ensureSchema(): void
    {
        $connection = DB::connection();

        if ($connection->getDriverName() !== 'pgsql') {
            return;
        }

        $schema = (string) ($connection->getConfig('search_path') ?: 'public');

        // A search_path can be a list ("app,public"); only the first entry is
        // the schema this application owns.
        $schema = trim(explode(',', $schema)[0]);

        if ($schema === '' || $schema === 'public') {
            return;
        }

        $quoted = '"'.str_replace('"', '""', $schema).'"';
        $connection->statement("CREATE SCHEMA IF NOT EXISTS {$quoted}");
    }

    /**
     * Create the initial user for a fresh install.
     *
     * The first user of an install must be an Admin so they can access
     * admin-only features (e.g. the Settings menu). The `role` column
     * defaults to "user", so it is set explicitly here rather than relying
     * on `make:filament-user`, which never sets a role.
     */
    protected function createDefaultUser(string $name, string $email, string $password): User
    {
        return User::create([
            'name' => $name,
            'email' => $email,
            'password' => $password,
            'role' => Role::Admin,
        ]);
    }
}
