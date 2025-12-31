#!/bin/bash

source .env
docker build \
  --no-cache \
  --build-arg PHPVERSION=$PHPVERSION \
  --build-arg SERVERNAME=$SERVERNAME \
  -t zmutclik/webapache:${PHPVERSION} .

# docker login
docker push zmutclik/webapache:${PHPVERSION}