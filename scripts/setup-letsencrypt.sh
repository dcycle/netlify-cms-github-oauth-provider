#!/bin/bash
#
# Set up Letsencrpyt as per https://blog.dcycle.com/blog/7f3ea9e1
#
set -e

mkdir -p "$HOME"/certs

docker run -d -p 80:80 -p 443:443 \
  --name nginx-proxy \
  -v "$HOME"/certs:/etc/nginx/certs:ro \
  -v /etc/nginx/vhost.d \
  -v /usr/share/nginx/html \
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy \
  --restart=always \
  jwilder/nginx-proxy

docker run -d \
  --name nginx-letsencrypt \
  -v "$HOME"/certs:/etc/nginx/certs:rw \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --volumes-from nginx-proxy \
  --restart=always \
  jrcs/letsencrypt-nginx-proxy-companion

docker network connect netlify_oauth_default nginx-proxy
docker restart nginx-letsencrypt
