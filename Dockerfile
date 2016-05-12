# alpine-caddy-docker
# https://github.com/Jamesits/alpine-caddy-docker
FROM alpine:latest
MAINTAINER James Swineson <jamesswineson@gmail.com>

ENV OS=linux \
    ARCH=amd64 \
    FEATURES=cors+git+hugo+ipfilter+jsonp+jwt+mailout+prometheus+realip+search+upload

# Get HTTPS support
RUN apk update \
    && apk add wget ca-certificates \
    && update-ca-certificates

# Install Caddy server
RUN mkdir -p /usr/local/src/caddy \
    && wget "https://caddyserver.com/download/build?os=${OS}&arch=${ARCH}&features=${FEATURES//+/%2C}" -O /tmp/caddy.tar.gz \
    && tar -C /usr/local/src/caddy -xvzf /tmp/caddy.tar.gz \
    && chmod +x /usr/local/src/caddy/caddy \
    && ln -s /usr/local/src/caddy/caddy /usr/local/bin/caddy

EXPOSE 2015
CMD ["caddy"]
