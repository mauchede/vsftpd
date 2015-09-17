#!/bin/bash
set -e

/usr/local/bin/syslog-stdout &

for OPTION in "$@" ; do
    echo $OPTION >> /etc/vsftpd.conf
done

vsftpd
