# Installation

Pull the image `timonier/vsftpd`:

```bash
# Get the latest image
docker pull timonier/vsftpd

# Or get a specific version

# Get the version 3.0.2
docker pull timonier/vsftpd:3.0.2
```

# Usage

Run your container via `docker run`. The [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html) can be passed as arguments:

```bash
docker run --name vsftpd -v /srv/ftp:/srv/ftp timonier/vsftpd:3.0.2 -oanonymous_enable=YES -osecure_chroot_dir=/srv/ftp
```

Image `timonier/vsftpd` is provided with:

* [syslog-stdout](https://github.com/mauchede/syslog-stdout). The connection logs are accessible via `docker logs`:

```bash
docker logs vsftpd
# ftp:info: Nov  2 15:30:17 vsftpd[11]: [ftp] OK LOGIN: Client "::ffff:127.0.0.1", anon password "anon@localhost"
```

* [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile). It is possible to have "virtual" users:

```bash
docker run -d -e PWD_FILE="/tmp/users" -p 21:21 --name vsftpd timonier/vsftpd:3.0.2 \
    -oanonymous_enable=NO \
    -oguest_enable=YES \
    -olocal_enable=YES

docker exec -ti vsftpd adduser-ftp usernameA passwordA
docker exec -ti vsftpd adduser-ftp usernameB passwordB
```

# Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

__Note__: Use the script `bin/build` to test your modifications locally.

# Links

* [command "docker pull"](https://docs.docker.com/reference/commandline/pull/)
* [command "docker logs"](https://docs.docker.com/reference/commandline/cli/)
* [command "docker run"](https://docs.docker.com/reference/run/)
* [image "timonier/vsftpd"](https://hub.docker.com/r/timonier/vsftpd/)
* [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile)
* [syslog-stdout](https://github.com/mauchede/syslog-stdout)
* [vsftpd](https://security.appspot.com/vsftpd.html)
* [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html)
