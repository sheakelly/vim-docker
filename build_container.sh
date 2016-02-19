#!/usr/bin/env bash
set -eo pipefail

if env | grep http_proxy
then
  echo 'Using proxy settings'
  echo
  docker build \
    --build-arg HTTP_PROXY=http://buildproxy.nibdom.com.au:3128 \
    --build-arg HTTPS_PROXY=http://buildproxy.nibdom.com.au:3128 \
    --build-arg http_proxy=http://buildproxy.nibdom.com.au:3128 \
    --build-arg https_proxy=http://buildproxy.nibdom.com.au:3128 \
    --rm -t docker-vim /vagrant
else
  docker build --rm -t docker-vim /vagrant
fi
