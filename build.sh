#!/bin/bash

JAVA_VERS="25"

for v in $JAVA_VERS
do
  sudo docker pull amazoncorretto:$v-alpine
done

MC_VERS="1.21.10 26.2 26.3"

for v in $MC_VERS
do
  sudo docker build --no-cache --build-arg MC_VER=$v -f Dockerfile_mcserver.txt -t mcserver:$v .
done

sudo docker build --no-cache --build-arg MC_VER=1.21.10 --build-arg FETCHR_VER=5.3.3 \
-f Dockerfile_Fetchr.txt -t mcinstance:fetchr-build-test-533 .

sudo docker build --no-cache --build-arg MC_VER=26.2 --build-arg FETCHR_VER=5.4-beta3 --build-arg FETCHR_SUF=-26.x \
-f Dockerfile_Fetchr.txt -t mcinstance:fetchr-build-test-54b3 .
