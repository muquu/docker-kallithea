# docker-kallithea

For use local network.

* [Official Kallithea page](https://kallithea-scm.org/)
* [My kallithea docker image](https://hub.docker.com/repository/docker/muquu/kallithea)

# build
```
> docker build -t muquu/kallithea:0.5.2 .
```

# usage

Prepare configulation file `my.ini` and database `kallithea.db` .

```
> docker run -d -p 80:80 \
-v /path/to/repos:/srv/repos \
-v /path/to/kallithea:/srv/kallithea  muquu/kallithea:0.5.2
```