#!/usr/bin/with-contenv /bin/sh

[ -z "$PWDFILE" ] && exit 0

[ ! -f "$PWDFILE" ] && touch $PWDFILE

cat > /etc/pam.d/ftp << EOF
auth required /lib/security/pam_pwdfile.so pwdfile $PWDFILE
account required /lib/security/pam_permit.so
EOF

exit 0
