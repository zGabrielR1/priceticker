<?php

// Internal-only compatibility endpoint for the scraper package. The PHP server
// is deliberately single-process: only one Chromium session can run at a time.
require dirname(__DIR__, 2).'/vendor/autoload.php';

use App\Rules\PublicHttpUrl;
use App\Services\BrowserPageRenderer;

header('Content-Type: application/json');

if (parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) === '/health') {
    echo json_encode(['status' => 'ok']);

    return;
}

if ($_SERVER['REQUEST_METHOD'] !== 'GET' || parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) !== '/api/article') {
    http_response_code(404);
    echo json_encode(['message' => 'Not found']);

    return;
}

$url = $_GET['url'] ?? '';
$error = null;
(new PublicHttpUrl)->validate('url', $url, function (string $message) use (&$error): void {
    $error = $message;
});

if ($error !== null) {
    http_response_code(422);
    echo json_encode(['message' => $error]);

    return;
}

try {
    $html = (new BrowserPageRenderer(getenv('CHROMIUM_BINARY') ?: '/usr/bin/chromium'))->render(
        $url,
        max(1, (int) ceil((int) ($_GET['timeout'] ?? 30000) / 1000)),
        (int) ($_GET['sleep'] ?? 2000),
    );
    echo json_encode(['fullContent' => $html], JSON_INVALID_UTF8_SUBSTITUTE);
} catch (Throwable $exception) {
    http_response_code(502);
    error_log('Browser render failed: '.$exception->getMessage());
    echo json_encode(['message' => 'Browser rendering failed or timed out.']);
}
