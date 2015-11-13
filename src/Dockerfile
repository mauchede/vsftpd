FROM alpine:3.1
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    LINUX_PAM_VERSION=1.1.8-r2 \
    VSFTPD_VERSION=3.0.2-r9

ADD https://github.com/mauchede/syslog-stdout/raw/v1.0.0/dist/syslog-stdout /usr/sbin/syslog-stdout

RUN set -x \
    && chmod +x /usr/sbin/syslog-stdout \
    && apk add -U linux-pam=$LINUX_PAM_VERSION vsftpd=$VSFTPD_VERSION \
    && echo "dual_log_enable=YES" >> /etc/vsftpd/vsftpd.conf \
    && echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf \
    && echo "syslog_enable=YES" >> /etc/vsftpd/vsftpd.conf \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
COPY pam_pwdfile.so /lib/security/pam_pwdfile.so

ENTRYPOINT [ "/entrypoint.sh" ]
