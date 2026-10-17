<?php

namespace App\Enums;

use App\Notifications\Channels\AppriseChannel;
use App\Notifications\Channels\DiscordChannel;
use App\Notifications\Channels\FcmChannel;
use App\Notifications\Channels\GotifyChannel;
use App\Notifications\Channels\NtfyChannel;
use App\Notifications\Channels\TelegramChannel;
use NotificationChannels\Pushover\PushoverChannel;

enum NotificationMethods: string
{
    case Mail = 'mail';

    case Database = 'database';

    case Pushover = 'pushover';

    case Gotify = 'gotify';

    case Apprise = 'apprise';

    case Telegram = 'telegram';

    case Discord = 'discord';

    case Ntfy = 'ntfy';

    case Fcm = 'fcm';

    public function getChannel(): string
    {
        return match ($this) {
            self::Pushover => PushoverChannel::class,
            self::Gotify => GotifyChannel::class,
            self::Apprise => AppriseChannel::class,
            self::Telegram => TelegramChannel::class,
            self::Discord => DiscordChannel::class,
            self::Ntfy => NtfyChannel::class,
            self::Fcm => FcmChannel::class,
            default => $this->value,
        };
    }

    public function requiresUserSettings(): bool
    {
        return match ($this) {
            self::Database => false,
            self::Fcm => false,
            default => true,
        };
    }
}
