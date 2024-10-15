#!/bin/bash

docker run -d \
  --name amcrest-web \
  -p 9999:80 \
  -p 9998:443 \
  -v "$(pwd)":/FQDN \
  -v "$(pwd)/FQDN.conf":/etc/nginx/conf.d/default.conf \
  --restart unless-stopped \
  nginx:latest
