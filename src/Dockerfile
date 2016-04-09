FROM alpine:3.3
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    LINUX_PAM_PWDFILE_VERSION=e29d26e \
    S6_OVERLAY_VERSION=1.17.1.2 \
    SYSLOG_STDOUT_VERSION=1.1.1 \
    VSFTPD_VERSION=3.0.3

RUN set -x \

    # Prepare system

    && resolve() { echo $(apk search $1 | grep "^$1-$2" | sed -e "s/$1-//g") ; } \

    && apk add -U \

    # Install packages

    && BUILD_DEPS="gcc git libc-dev make linux-pam-dev" \
    && RESOLVED_VSFTPD_VERSION=$(resolve vsftpd $VSFTPD_VERSION) \

    && apk add \
        $BUILD_DEPS \
        apache2-utils \
        linux-pam \
        vsftpd=${RESOLVED_VSFTPD_VERSION:?"Impossible to find 'vsftpd' in version '$VSFTPD_VERSION'"} \

    # Install s6-overlay

    && curl -ksL "https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz" | tar fxz - -C / \

    # Install syslog-stdout

    && curl -ksL "https://github.com/timonier/syslog-stdout/releases/download/v$SYSLOG_STDOUT_VERSION/syslog-stdout.tar.gz" | tar fxz - -C /usr/sbin \

    # Compile libpam-pwdfile

    && git clone https://github.com/tiwe-de/libpam-pwdfile /tmp/libpam-pwdfile \
    && git -C /tmp/libpam-pwdfile checkout $LINUX_PAM_PWDFILE_VERSION \
    && make -C /tmp/libpam-pwdfile \
    && make -C /tmp/libpam-pwdfile install \

    # Configure vsftpd

    && > /etc/vsftpd/vsftpd.conf \
    && echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf \
    && echo "syslog_enable=YES" >> /etc/vsftpd/vsftpd.conf \
    && echo "xferlog_enable=YES" >> /etc/vsftpd/vsftpd.conf \

    # Clean

    && apk del \
           $BUILD_DEPS \

    && rm -rf \
           /tmp/* \
           /var/cache/apk/*

COPY ./rootfs /

ENTRYPOINT [ "/init" , "/usr/sbin/vsftpd" , "/etc/vsftpd/vsftpd.conf" ]
