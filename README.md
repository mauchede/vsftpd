# vsftpd

Dockerized [vsftpd](https://security.appspot.com/vsftpd.html): Very Secure FTP Daemon.

## How to use it?

Copy the script `bin/service` into `/etc/init.d/vsftpd` and use the command `service`:

```bash
sudo cp bin/service /etc/init.d/vsftpd
sudo service start
```

## How to configure it?

By default the service will:
* use the image `mauchede/vsftpd:3.0.2`.
* start a container named `vsftpd`.
* use the host's network stack.
* use the folder `/srv/ftp`.
* bind the folder `/srv/ftp` to the host.
* allow the anonymous users.

To override the default configuration, use the file `/etc/default/vsftpd`. The available parameters are:
* `IMAGE`
* `TAG`
* `CONTAINER_NAME`
* `CONTAINER_OPTIONS`
* `VSFTPD_OPTIONS`

In `CONTAINER_OPTIONS`, it is possible to define the [Docker options](https://docs.docker.com/reference/run/). The default value is:

```bash
--net host -v /srv/ftp:/srv/ftp
```

In `VSFTPD_OPTIONS`, it is possible to define the option of the [vsftpd server](https://security.appspot.com/vsftpd/vsftpd_conf.html). The default value is:

```bash
anonymous_enable=YES dual_log_enable=YES seccomp_sandbox=NO secure_chroot_dir=/srv/ftp syslog_enable=YES
```
