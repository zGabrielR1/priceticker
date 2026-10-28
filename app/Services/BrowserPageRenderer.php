<?php

namespace App\Services;

use RuntimeException;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Process\Exception\ProcessSignaledException;
use Symfony\Component\Process\Process;

/** A single-use Chromium profile keeps retailer sessions isolated. */
class BrowserPageRenderer
{
    public function __construct(protected string $binary = '/usr/bin/chromium') {}

    public function render(string $url, int $timeout = 30, int $wait = 2000): string
    {
        $profile = sys_get_temp_dir().'/priceticker-browser-'.bin2hex(random_bytes(12));
        if (! mkdir($profile, 0700)) {
            throw new RuntimeException('Could not create a browser session.');
        }

        try {
            $process = $this->process([
                $this->binary,
                '--headless', '--no-sandbox', '--disable-dev-shm-usage', '--disable-gpu',
                '--disable-background-networking', '--disable-extensions', '--no-first-run',
                '--no-default-browser-check', '--renderer-process-limit=1',
                '--js-flags=--max-old-space-size=96', '--window-size=1365,768',
                '--user-data-dir='.$profile,
                '--virtual-time-budget='.max(0, min($wait, 5000)),
                '--dump-dom', $url,
            ]);
            // Supervisor runs this as www-data. Chromium's crash reporter must
            // not inherit root's unwritable home/config directories.
            $process->setEnv([
                'HOME' => $profile,
                'XDG_CONFIG_HOME' => $profile.'/config',
                'XDG_CACHE_HOME' => $profile.'/cache',
            ]);
            $process->setTimeout(max(1, min($timeout, 45)));
            try {
                $process->run();
            } catch (ProcessSignaledException $error) {
                error_log('Chromium signal '.$error->getSignal().': '.substr($process->getErrorOutput(), -3000));
                throw new RuntimeException('The browser process stopped unexpectedly.', previous: $error);
            }

            if (! $process->isSuccessful() || trim($process->getOutput()) === '') {
                throw new RuntimeException('The browser could not load the product page.');
            }

            return $process->getOutput();
        } finally {
            (new Filesystem)->remove($profile);
        }
    }

    /** @param array<int, string> $command */
    protected function process(array $command): Process
    {
        return new Process($command);
    }
}
