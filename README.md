# README

Very Secure FTP Daemon

## Usage

Run the application via `docker run`. The [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html) can be passed as environment variables:

```sh
docker run \
    --env VSFTPD_OPTION_ANONYMOUS_ENABLE=YES \
    --env VSFTPD_OPTION_SECURE_CHROOT_DIR=/srv/ftp \
    --name vsftpd \
    --publish 21:21 \
    --volume /srv/ftp:/srv/ftp \
    timonier/vsftpd
```

Image `timonier/vsftpd` is provided with:

* [syslog-stdout](https://github.com/timonier/syslog-stdout). The connection logs are accessible via `docker logs`:

```sh
docker logs vsftpd
# ...
# ftp:info: Nov  2 15:30:17 vsftpd[11]: [ftp] OK LOGIN: Client "::ffff:127.0.0.1", anon password "anon@localhost"
```

* [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile). It is possible to have "virtual" users:

```sh
docker run \
    --detach \
    --env PAM_PWDFILE="/tmp/users" \
    --env VSFTPD_OPTION_ALLOW_WRITEABLE_CHROOT=YES \
    --env VSFTPD_OPTION_ANONYMOUS_ENABLE=NO \
    --env VSFTPD_OPTION_CHROOT_LOCAL_USER=YES \
    --env VSFTPD_OPTION_GUEST_ENABLE=YES \
    --env VSFTPD_OPTION_GUEST_USERNAME=root \
    --env VSFTPD_OPTION_LOCAL_ENABLE=YES \
    --env VSFTPD_OPTION_LOCAL_ROOT=/srv/ftp \
    --env VSFTPD_OPTION_PASV_ENABLE=NO \
    --env VSFTPD_OPTION_VIRTUAL_USE_LOCAL_PRIVS=YES \
    --env VSFTPD_OPTION_WRITE_ENABLE=YES \
    --name vsftpd \
    --net host \
    --volume /srv/ftp:/srv/ftp \
    timonier/vsftpd

docker exec -ti vsftpd adduser-ftp usernameA passwordA
docker exec -ti vsftpd adduser-ftp usernameB passwordB
```

## Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

__Note__: Use the script `bin/build` to test your modifications locally.

## Links

* [command "docker logs"](https://docs.docker.com/reference/commandline/cli/)
* [command "docker run"](https://docs.docker.com/reference/run/)
* [image "timonier/vsftpd"](https://hub.docker.com/r/timonier/vsftpd/)
* [timonier/dumb-entrypoint](https://github.com/timonier/dumb-entrypoint)
* [timonier/syslog-stdout](https://github.com/timonier/syslog-stdout)
* [timonier/version-lister](https://github.com/timonier/version-lister)
* [tiwe-de/libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile)
* [vsftpd](https://security.appspot.com/vsftpd.html)
* [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html)
