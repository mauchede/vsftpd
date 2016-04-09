# README

## Installation

Pull the image `timonier/vsftpd`:

```sh
# Get the latest image (version 3.0.3)
docker pull timonier/vsftpd

# Or get a specific version

# Get the version 3.0.2
docker pull timonier/vsftpd:3.0.2
```

## Usage

Run the application via `docker run`. The [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html) can be passed as arguments:

```sh
docker run \
    -p 21:21 \
    -v /srv/ftp:/srv/ftp \
    --name vsftpd \
    timonier/vsftpd \
        -oanonymous_enable=YES \
        -osecure_chroot_dir=/srv/ftp
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
    -d \
    -e PWDFILE="/tmp/users" \
    -v /srv/ftp:/srv/ftp \
    --name vsftpd \
    --net host \
    timonier/vsftpd \
        -oallow_writeable_chroot=YES \
        -oanonymous_enable=NO \
        -ochroot_local_user=YES \
        -oguest_enable=YES \
        -oguest_username=root \
        -opasv_enable=NO \
        -olocal_enable=YES \
        -olocal_root=/srv/ftp \
        -ovirtual_use_local_privs=YES \
        -owrite_enable=YES

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

* [command "docker pull"](https://docs.docker.com/reference/commandline/pull/)
* [command "docker logs"](https://docs.docker.com/reference/commandline/cli/)
* [command "docker run"](https://docs.docker.com/reference/run/)
* [image "timonier/vsftpd"](https://hub.docker.com/r/timonier/vsftpd/)
* [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile)
* [s6-overlay](https://github.com/just-containers/s6-overlay)
* [syslog-stdout](https://github.com/timonier/syslog-stdout)
* [vsftpd](https://security.appspot.com/vsftpd.html)
* [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html)
