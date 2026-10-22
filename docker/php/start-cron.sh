#!/bin/sh
#
# Install the application crontab, then run cron in the foreground so
# supervisor can restart it if it ever exits.
set -eu

crontab /etc/cron.d/schedule-cron
exec /usr/sbin/cron -f -L 1
