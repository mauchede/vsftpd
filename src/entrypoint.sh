#!/bin/sh
set -e

/usr/local/bin/syslog-stdout &

exec /usr/sbin/vsftpd /etc/vsftpd.conf "$@"
