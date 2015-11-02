# vsftpd

Dockerized [vsftpd](https://security.appspot.com/vsftpd.html): Very Secure FTP Daemon.

## Install

### Standard

Pull the image `mauchede/vsftpd`:

```bash
# Get the latest image
docker pull mauchede/vsftpd

# Or get a specific version

# Get the version 3.0.2
docker pull mauchede/vsftpd:3.0.2
```

### Service

Copy the script `bin/service` into `/etc/init.d/vsftpd`:

```
sudo curl -sLo /etc/init.d/vsftpd https://github.com/mauchede/vsftpd/raw/master/bin/service
sudo chmod +x /etc/init.d/vsftpd
```

## Usage

### Standard

Run your container via `docker run`. The [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html) can be passed as arguments. For example:

```bash
docker run --name vsftpd -v /srv/ftp:/srv/ftp mauchede/vsftpd:3.0.2 anonymous_enable=YES secure_chroot_dir=/srv/ftp
```

Image `mauchede/vsftpd` is provided with [syslog-stdout](https://github.com/mauchede/syslog-stdout). The connection logs are accessible via `docker logs`:

```bash
docker logs vsftpd
# ftp:info: Nov  2 15:30:17 vsftpd[11]: [ftp] OK LOGIN: Client "::ffff:127.0.0.1", anon password "anon@localhost"
```

### Service

You can manage the service via the command `service`:

```bash
sudo service start
# ...
sudo service status
# ...
sudo service stop
```

The default configuration is:

```bash
CONTAINER_NAME="vsftpd"
CONTAINER_OPTIONS="--net host -v /srv/ftp:/srv/ftp"
VSFTPD_OPTIONS="anonymous_enable=YES secure_chroot_dir=/srv/ftp"
IMAGE="mauchede/vsftpd"
TAG="3.0.2"
```

This configuration will:
* use the image `mauchede/vsftpd:3.0.2`.
* start a container named `vsftpd`.
* use the host's network stack.
* use the folder `/srv/ftp`.
* bind the folder `/srv/ftp` to the host.
* allow the anonymous users.

To override these parameters, add into `/etc/default/vsftpd` your own values. For example:

```bash
# Change the container name
CONTAINER_NAME="other_name"

# Add "guest_enable" to VSFTPD_OPTIONS
VSFTPD_OPTIONS="$VSFTPD_OPTIONS guest_enable=YES"
```

## Links

* [command "docker pull"](https://docs.docker.com/reference/commandline/pull/)
* [command "docker logs"](https://docs.docker.com/reference/commandline/cli/)
* [command "docker run"](https://docs.docker.com/reference/run/)
* [image "mauchede/vsftpd"](https://hub.docker.com/r/mauchede/vsftpd/)
* [syslog-stdout](https://github.com/mauchede/syslog-stdout)
* [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html)
