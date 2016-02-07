#!/bin/sh

[[ -n $PWD_FILE ]] && cat > /etc/pam.d/ftp << EOF
auth required /lib/security/pam_pwdfile.so pwdfile $PWD_FILE
account required /lib/security/pam_permit.so
EOF

/usr/sbin/syslog-stdout &

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf "$@"
