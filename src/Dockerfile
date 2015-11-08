FROM alpine:3.1
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    DEBIAN_FRONTEND=noninteractive \
    LINUX_PAM_VERSION=1.1.8-r2 \
    VSFTPD_VERSION=3.0.2-r9

ADD https://github.com/mauchede/syslog-stdout/raw/master/dist/syslog-stdout /usr/local/bin/syslog-stdout

RUN set -x \
    && chmod +x /usr/local/bin/syslog-stdout \
    && apk add -U linux-pam=$LINUX_PAM_VERSION vsftpd=$VSFTPD_VERSION \
    && echo "dual_log_enable=YES" >> /etc/vsftpd.conf \
    && echo "seccomp_sandbox=NO" >> /etc/vsftpd.conf \
    && echo "syslog_enable=YES" >> /etc/vsftpd.conf \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
