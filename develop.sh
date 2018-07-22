#!/bin/bash

docker rm -f nginx le iw

docker build -f Dockerfile -t immutable-web .

docker network create iw-network

docker run -d \
   -p 80:80 \
   --name immutableweb \
   -v `pwd`:/code/iw \
   --env "VIRTUAL_HOST=dev.immutableweb.org" \
   --env "LETSENCRYPT_HOST=dev.immutableweb.org" \
   --env "LETSENCRYPT_EMAIL=mayhem@gmail.com" \
   --restart unless-stopped \
   --network=stashit-network \
   --entrypoint="python3" iw /code/iw/server.py runserver --debug --port 80 --host 0.0.0.0 
