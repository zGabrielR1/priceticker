<?php

namespace App\Services\Helpers;

/**
 * Parse Brazilian-formatted prices (e.g. "R$ 1.234,56", "1.234,56", "1234,56")
 * into a float. Safe to call with null/empty input.
 */
class BrazilianPrice
{
    public static function parse(?string $value): ?float
    {
        if (blank($value)) {
            return null;
        }

        $s = trim((string) $value);

        // Drop currency symbols, spaces and non-breaking spaces.
        $s = preg_replace('/[R$\s\x{00A0}]/u', '', $s);

        if ($s === '' || $s === '-' || $s === '.') {
            return null;
        }

        // Brazilian format: dot = thousands, comma = decimal.
        if (str_contains($s, ',') && str_contains($s, '.')) {
            $s = str_replace('.', '', $s);
            $s = str_replace(',', '.', $s);
        } elseif (str_contains($s, ',')) {
            $s = str_replace(',', '.', $s);
        }

        // Keep only digits, dot and minus.
        $s = preg_replace('/[^0-9.\-]/', '', $s);

        if ($s === '' || $s === '.' || $s === '-') {
            return null;
        }

        if (! is_numeric($s)) {
            return null;
        }

        return (float) $s;
    }
}
