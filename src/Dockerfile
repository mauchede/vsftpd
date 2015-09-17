FROM debian:jessie
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

ENV VSFTPD_VERSION 3.0.2-17

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends vsftpd=$VSFTPD_VERSION \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://raw.githubusercontent.com/mauchede/syslog-stdout/master/dist/syslog-stdout /usr/local/bin/syslog-stdout
RUN chmod +x /usr/local/bin/syslog-stdout

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
