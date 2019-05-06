#!/bin/bash

docker run -d \
    --expose 3031 \
    --name immutableweb-org \
    --env "VIRTUAL_HOST=immutableweb.org" \
    --env "LETSENCRYPT_HOST=immutableweb.org" \
    --env "LETSENCRYPT_EMAIL=mayhem@gmail.com" \
    --network=website-network \
    --restart unless-stopped \
    immutableweb-org:beta
