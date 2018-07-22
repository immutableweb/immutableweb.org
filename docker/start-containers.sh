#!/bin/bash

docker run -d \
    --expose 3031 \
    --name immutableweb-org \
    -v /home/website/immutableweb.org:/code/iw \
    --env "VIRTUAL_HOST=immutableweb.org" \
    --env "LETSENCRYPT_HOST=immutableweb.org" \
    --env "LETSENCRYPT_EMAIL=mayhem@gmail.com" \
    --network=website-network \
    immutableweb-org:beta
