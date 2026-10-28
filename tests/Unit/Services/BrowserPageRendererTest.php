<?php

namespace Tests\Unit\Services;

use App\Services\BrowserPageRenderer;
use Mockery;
use PHPUnit\Framework\TestCase;
use RuntimeException;
use Symfony\Component\Process\Process;

class BrowserPageRendererTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_rendering_bounds_runtime_and_cleans_session_directory(): void
    {
        $process = Mockery::mock(Process::class);
        $process->shouldReceive('setTimeout')->once()->with(45);
        $process->shouldReceive('run')->once();
        $process->shouldReceive('isSuccessful')->andReturn(true);
        $process->shouldReceive('getOutput')->andReturn('<html>Rendered product</html>');
        $renderer = new TestBrowserRenderer($process);

        $this->assertSame('<html>Rendered product</html>', $renderer->render('https://example.com/product', 600, 10000));
        $this->assertContains('--virtual-time-budget=5000', $renderer->command);
        $this->assertSame('https://example.com/product', end($renderer->command));
        $this->assertDirectoryDoesNotExist($renderer->profile());
    }

    public function test_failed_browser_process_does_not_leave_a_session(): void
    {
        $process = Mockery::mock(Process::class);
        $process->shouldReceive('setTimeout')->once()->with(30);
        $process->shouldReceive('run')->once();
        $process->shouldReceive('isSuccessful')->andReturn(false);
        $renderer = new TestBrowserRenderer($process);

        try {
            $renderer->render('https://example.com/product');
            $this->fail('Expected a browser error.');
        } catch (RuntimeException $error) {
            $this->assertSame('The browser could not load the product page.', $error->getMessage());
            $this->assertDirectoryDoesNotExist($renderer->profile());
        }
    }
}

class TestBrowserRenderer extends BrowserPageRenderer
{
    public array $command = [];

    public function __construct(private Process $fake)
    {
        parent::__construct('/usr/bin/chromium');
    }

    protected function process(array $command): Process
    {
        $this->command = $command;

        return $this->fake;
    }

    public function profile(): string
    {
        foreach ($this->command as $argument) {
            if (str_starts_with($argument, '--user-data-dir=')) {
                return substr($argument, strlen('--user-data-dir='));
            }
        }

        throw new RuntimeException('No profile directory supplied.');
    }
}
