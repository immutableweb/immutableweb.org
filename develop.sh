#!/bin/bash

docker rm -f nginx le immutableweb-org

docker build -f Dockerfile -t immutableweb-org .

docker network create iw-network

docker run -d \
   -p 80:80 \
   --name immutableweb-org \
   -v `pwd`:/code/iw \
   --env "VIRTUAL_HOST=dev.immutableweb.org" \
   --env "LETSENCRYPT_HOST=dev.immutableweb.org" \
   --env "LETSENCRYPT_EMAIL=mayhem@gmail.com" \
   --network=iw-network \
   --entrypoint="python3" \
   immutableweb-org /code/iw/server.py runserver --debug --port 80 --host 0.0.0.0 
#   --restart unless-stopped \
