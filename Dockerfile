FROM alpine:3.6
LABEL maintainer "Chris Collazo <chris@collazo.me>"

LABEL caddy_version="0.11.0"

RUN apk add --no-cache openssh-client git curl bash

# install caddy
RUN curl https://getcaddy.com | bash -s personal http.authz,http.awslambda,http.cache,http.cgi,http.cors,http.expires,http.filemanager,http.filter,http.forwardproxy,http.geoip,http.git,http.grpc,http.ipfilter,http.jwt,http.locale,http.login,http.minify,http.nobots,http.ratelimit,http.realip,http.reauth,http.upload,http.webdav,tls.dns.googlecloud
# validate install
RUN /usr/local/bin/caddy -version
RUN /usr/local/bin/caddy -plugins

EXPOSE 80 443 2015
VOLUME /root/.caddy /srv
WORKDIR /srv

ENTRYPOINT ["/usr/local/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
