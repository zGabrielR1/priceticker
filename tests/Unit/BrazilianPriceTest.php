<?php

namespace Tests\Unit;

use App\Services\Helpers\BrazilianPrice;
use Tests\TestCase;

class BrazilianPriceTest extends TestCase
{
    /** @dataProvider cases */
    public function test_parse(?string $input, ?float $expected): void
    {
        $this->assertSame($expected, BrazilianPrice::parse($input));
    }

    public static function cases(): array
    {
        return [
            ['R$ 1.234,56', 1234.56],
            ['1.234,56', 1234.56],
            ['1234,56', 1234.56],
            ['R$ 99,90', 99.9],
            ['R$1.299,00', 1299.0],
            ['99.90', 99.9],
            [null, null],
            ['', null],
            ['abc', null],
            ['R$ 0,00', 0.0],
        ];
    }
}
