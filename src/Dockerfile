FROM alpine:3.1
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    APACHE2_UTILS_VERSION=2.4.16 \
    LIB_PAM_VERSION=1.1.8 \
    LIB_PAM_PWDFILE_VERSION=e29d26e \
    SYSLOG_STDOUT_VERSION=1.0.0 \
    VSFTPD_VERSION=3.0.2

RUN set -x \

    # Prepare system

    && resolve() { echo $(apk search $1 | grep "$1-$2" | sed -e "s/$1-/$1=/g") ; } \
    && apk add -U \

    # Install packages

    && BUILD_DEPS="gcc git libc-dev make linux-pam-dev" \
    && apk add \
        $BUILD_DEPS \
        $(resolve apache2-utils $APACHE2_UTILS_VERSION) \
        $(resolve linux-pam $LIB_PAM_VERSION) \
        $(resolve vsftpd $VSFTPD_VERSION) \
    && curl -sLo /usr/sbin/syslog-stdout "https://github.com/mauchede/syslog-stdout/raw/v$SYSLOG_STDOUT_VERSION/dist/syslog-stdout" \
    && chmod +x /usr/sbin/syslog-stdout \

    # Compile libpam-pwdfile

    && git clone https://github.com/tiwe-de/libpam-pwdfile /tmp/libpam-pwdfile \
    && git -C /tmp/libpam-pwdfile checkout $LIB_PAM_PWDFILE_VERSION \
    && make -C /tmp/libpam-pwdfile \
    && make -C /tmp/libpam-pwdfile install \

    # Configure vsftpd

    && echo > /etc/vsftpd/vsftpd.conf \
    && echo "dual_log_enable=YES" >> /etc/vsftpd/vsftpd.conf \
    && echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf \
    && echo "syslog_enable=YES" >> /etc/vsftpd/vsftpd.conf \

    # Clean

    && apk del \
           $BUILD_DEPS \
    && rm -rf \
           /var/cache/apk/* \
           /tmp/*

COPY ./root /

ENTRYPOINT [ "/entrypoint.sh" ]
