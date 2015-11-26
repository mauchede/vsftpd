FROM alpine:3.1
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    APACHE2_UTILS_VERSION=2.4.16-r0 \
    LIB_PAM_VERSION=1.1.8-r2 \
    LIB_PAM_PWDFILE_VERSION=e29d26e \
    SYSLOG_STDOUT_VERSION=1.0.0 \
    VSFTPD_VERSION=3.0.2-r9

ADD https://github.com/mauchede/syslog-stdout/raw/v$SYSLOG_STDOUT_VERSION/dist/syslog-stdout /usr/sbin/syslog-stdout

RUN set -x \
    && chmod +x /usr/sbin/syslog-stdout \
    && BUILD_DEPS="gcc git libc-dev make linux-pam-dev" \
    && apk add -U \
        $BUILD_DEPS \
        apache2-utils=$APACHE2_UTILS_VERSION \
        linux-pam=$LIB_PAM_VERSION \
        vsftpd=$VSFTPD_VERSION \
    && git clone https://github.com/tiwe-de/libpam-pwdfile /tmp/libpam-pwdfile \
    && git -C /tmp/libpam-pwdfile checkout $LIB_PAM_PWDFILE_VERSION \
    && make -C /tmp/libpam-pwdfile \
    && make -C /tmp/libpam-pwdfile install \
    && echo > /etc/vsftpd/vsftpd.conf \
    && echo "dual_log_enable=YES" >> /etc/vsftpd/vsftpd.conf \
    && echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf \
    && echo "syslog_enable=YES" >> /etc/vsftpd/vsftpd.conf \
    && apk del $BUILD_DEPS \
    && rm -rf /var/cache/apk/* /tmp/*

COPY ./root /

ENTRYPOINT [ "/entrypoint.sh" ]
