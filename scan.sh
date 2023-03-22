#!/bin/bash

projectDir=$1
createdProjectKey=$2
loginToken=$3

docker run \
  --network=host \
  -e SONAR_HOST_URL='http://127.0.0.1:2000' \
  -it --rm \
  -v "${projectDir}":/usr/src \
  -v "$HOME/.sonar/cache:/root/.sonar/cache" \
  sonarsource/sonar-scanner-cli \
  sonar-scanner \
  -Dsonar.projectKey=${createdProjectKey} \
  -Dsonar.sources=. \
  -Dsonar.exclusions=node_modules/** \
  -Dsonar.login=${loginToken}
