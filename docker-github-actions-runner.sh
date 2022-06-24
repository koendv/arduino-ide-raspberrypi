#!/bin/sh

# before use, modify:
# DOCKER_DIR is the directory of the Dockerfile
# ACCESS_TOKEN is your github access token
# REPO_URL is the url of your fork of the arduino ide

DOCKER_DIR=/home/koen/src/docker-github-actions-runner

docker build ${DOCKER_DIR} --tag self-hosted-runner
docker run --env 'ACCESS_TOKEN=ghp_YOUR_ACCESS_TOKEN' --env RUNNER_SCOPE=repo --env 'REPO_URL=https://github.com/YOUR_GITHUB/arduino-ide' --env RUNNER_NAME=arduino-ide-runner self-hosted-runner
