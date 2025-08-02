#!/bin/bash

source .env
docker build \
  --no-cache \
  --build-arg PHPVERSION=$PHPVERSION \
  --build-arg SERVERNAME=$SERVERNAME \
  -t webapache:${PHPVERSION} .

# docker login
docker tag webapache:${PHPVERSION} zmutclik/webapache:${PHPVERSION}
# docker push zmutclik/webapache:${PHPVERSION}