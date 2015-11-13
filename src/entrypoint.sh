#!/bin/sh
set -e

/usr/sbin/syslog-stdout &

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf "$@"
