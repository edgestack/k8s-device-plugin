#!/usr/bin/env bash

set -ex
set -o pipefail

TAG=${TAG:-latest}
REPO=${REPO:-registry.gitlab.com/sonaproject}

# support other container tools. e.g. podman
CONTAINER_CLI=${CONTAINER_CLI:-docker}
CONTAINER_BUILDER=${CONTAINER_BUILDER:-"buildx build"}

# supported platforms
PLATFORMS=linux/amd64,linux/arm64

# shellcheck disable=SC2086 # inteneded splitting of CONTAINER_BUILDER
${CONTAINER_CLI} ${CONTAINER_BUILDER} \
  --platform ${PLATFORMS} \
  --push \
  -f ./deployments/container/Dockerfile.ubuntu \
  -t "${REPO}"/k8s-device-plugin:"${TAG}" .
