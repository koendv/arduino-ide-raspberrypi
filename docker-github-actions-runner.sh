#!/bin/sh

# before use, modify:
# DOCKER_DIR is the directory of 'git clone https://github.com/myoung34/docker-github-actions-runner'
# ACCESS_TOKEN is your github access token
# REPO_URL is the url of your fork of the arduino ide

DOCKER_DIR=/home/koen/src/docker-github-actions-runner

docker build ${DOCKER_DIR} --tag ubuntu-bionic
docker run --env 'ACCESS_TOKEN=ghp_your_github_token' --env RUNNER_SCOPE=repo --env 'REPO_URL=https://github.com/your_github/arduino-ide' --env RUNNER_NAME=arduino-ide-runner ubuntu-bionic
