### Installation

Pull the image `mauchede/vsftpd`:

```bash
# Get the latest image
docker pull mauchede/vsftpd

# Or get a specific version

# Get the version 3.0.2
docker pull mauchede/vsftpd:3.0.2
```

### Usage

Run your container via `docker run`. The [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html) can be passed as arguments. For example:

```bash
docker run --name vsftpd -v /srv/ftp:/srv/ftp mauchede/vsftpd:3.0.2 -oanonymous_enable=YES -osecure_chroot_dir=/srv/ftp
```

Image `mauchede/vsftpd` is provided with:

* [syslog-stdout](https://github.com/mauchede/syslog-stdout). The connection logs are accessible via `docker logs`:

```bash
docker logs vsftpd
# ftp:info: Nov  2 15:30:17 vsftpd[11]: [ftp] OK LOGIN: Client "::ffff:127.0.0.1", anon password "anon@localhost"
```

* [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile). It is possible to have "virtual" users:

```bash
cat pam.d/ftp
# auth required /lib/security/pam_pwdfile.so pwdfile /users
# account required /lib/security/pam_permit.so

htpasswd -db users usernameA passwordA
htpasswd -db users usernameB passwordB

docker run -v $PWD/pam.d:/etc/pam.d -v $PWD/users:/users mauchede/vsftpd:3.0.2 \
    -oanonymous_enable=NO \
    -oguest_enable=YES \
    -olocal_enable=YES
```

### Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

__Note__: Use the script `bin/build` to test your modifications locally.

### Links

* [command "docker pull"](https://docs.docker.com/reference/commandline/pull/)
* [command "docker logs"](https://docs.docker.com/reference/commandline/cli/)
* [command "docker run"](https://docs.docker.com/reference/run/)
* [image "mauchede/vsftpd"](https://hub.docker.com/r/mauchede/vsftpd/)
* [libpam-pwdfile](https://github.com/tiwe-de/libpam-pwdfile)
* [syslog-stdout](https://github.com/mauchede/syslog-stdout)
* [vsftpd options](https://security.appspot.com/vsftpd/vsftpd_conf.html)
