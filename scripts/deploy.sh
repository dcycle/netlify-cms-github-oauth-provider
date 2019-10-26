#!/bin/bash
#
# Deploy the Netlify CMS GitHub OAuth provider.
#
set -e

# See http://patorjk.com/software/taag/#p=display&f=Ivrit&t=Steward%208
cat ./scripts/lib/ascii-art.txt

source ./scripts/lib/source-env-file.sh

echo ''
echo 'About to try to get the latest version of node from the Docker hub.'
docker pull node

echo ''
echo '-----'
echo 'About to create the steward8_default network if it does not exist,'
echo 'because we need it to have a predictable name when we try to connect'
echo 'other containers to it (for example browser testers).'
echo 'steward8_default is then referenced in docker-compose.yml.'
echo 'See https://github.com/docker/compose/issues/3736.'
docker network ls | grep netlify_oauth_default || docker network create netlify_oauth_default

echo ''
echo '-----'
echo 'About to start persistent (-d) containers based on the images defined'
echo 'in ./Dockerfile-* files. We are also telling docker-compose to'
echo 'rebuild the images if they are out of date.'
docker-compose up -d --build

docker-compose ps
