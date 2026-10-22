<?php

namespace App\Enums;

enum ApiAbility: string
{
    case MetaExtractionExtract = 'meta-extraction:extract';

    case UserDetail = 'user:detail';

    case ClientConfigRead = 'client-config:read';

    case WatchesRead = 'watches:read';

    case WatchesWrite = 'watches:write';

    case DevicesWrite = 'devices:write';

    case PricesRead = 'prices:read';

    case AlertsRead = 'alerts:read';

    case AlertsWrite = 'alerts:write';

    case AccountManage = 'account:manage';

    public function label(): string
    {
        return match ($this) {
            self::MetaExtractionExtract => 'Extract metadata from a URL',
            self::UserDetail => 'Read the authenticated account',
            self::ClientConfigRead => 'Read client capability configuration',
            self::WatchesRead => 'Read watches and their rules',
            self::WatchesWrite => 'Create, update and delete watches',
            self::DevicesWrite => 'Register and remove push devices',
            self::PricesRead => 'Read product price history',
            self::AlertsRead => 'Read the alert inbox',
            self::AlertsWrite => 'Mark alerts as read',
            self::AccountManage => 'Manage the current API session',
        };
    }

    public function group(): string
    {
        return match ($this) {
            self::MetaExtractionExtract => 'Meta extraction',
            self::UserDetail, self::AccountManage => 'Account',
            self::ClientConfigRead => 'Client config',
            self::WatchesRead, self::WatchesWrite => 'Watches',
            self::DevicesWrite => 'Devices',
            self::PricesRead => 'Prices',
            self::AlertsRead, self::AlertsWrite => 'Alerts',
        };
    }
}
