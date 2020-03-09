# docker-gitweb

# build
```
> docker build -t muquu/kallithea:0.5.2 .
```

# usage
```
> docker run -d -p 80:80 \
-v /path/to/repos:/srv/repos \
-v /path/to/kallithea:/srv/kallithea  muquu/gitweb:0.5.2
```