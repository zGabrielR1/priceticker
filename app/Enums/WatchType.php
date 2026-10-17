<?php

namespace App\Enums;

use Filament\Support\Contracts\HasDescription;
use Filament\Support\Contracts\HasLabel;

enum WatchType: string implements HasDescription, HasLabel
{
    case Product = 'product';
    case Family = 'family';
    case Category = 'category';
    case Brand = 'brand';
    case Coupon = 'coupon';

    public function getLabel(): string
    {
        return match ($this) {
            self::Product => 'Product (single URL)',
            self::Family => 'Family (named product with variants)',
            self::Category => 'Category (retailer category/search URL, top N)',
            self::Brand => 'Brand (brand + keywords + filters)',
            self::Coupon => 'Coupon (promo feeds with keyword match)',
        };
    }

    public function getDescription(): string
    {
        return match ($this) {
            self::Product => 'Track one specific product URL.',
            self::Family => 'Track a named product across its variants and match rules.',
            self::Category => 'Track the top N items of a retailer category or search URL.',
            self::Brand => 'Track items by brand plus keyword and filter rules.',
            self::Coupon => 'Track coupon/promo feeds and match by keywords.',
        };
    }

    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }
}
