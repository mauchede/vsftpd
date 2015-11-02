FROM debian:jessie
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV \
    DEBIAN_FRONTEND=noninteractive \
    VSFTPD_VERSION=3.0.2

ADD https://github.com/mauchede/syslog-stdout/raw/master/dist/syslog-stdout /usr/local/bin/syslog-stdout
RUN chmod +x /usr/local/bin/syslog-stdout

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends libpam-mysql vsftpd=$VSFTPD_VERSION* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -x \
    && echo "dual_log_enable=YES" >> /etc/vsftpd.conf \
    && echo "seccomp_sandbox=NO" >> /etc/vsftpd.conf \
    && echo "syslog_enable=YES" >> /etc/vsftpd.conf

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
