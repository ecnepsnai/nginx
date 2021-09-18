#!/bin/sh
set -e

REVISION=$(git rev-parse HEAD)
VERSION=$(git describe)
DATETIME=$(date --rfc-3339=seconds)
NUM_THREADS=$(nproc)

podman build \
    -t ghcr.io/ecnepsnai/nginx:latest \
    -t ghcr.io/ecnepsnai/nginx:${VERSION} \
    --squash \
    --no-cache \
    --build-arg "NUM_THREADS=${NUM_THREADS}" \
    --label "org.opencontainers.image.created=${DATETIME}" \
    --label "org.opencontainers.image.version=${VERSION}" \
    --label "org.opencontainers.image.revision=${REVISION}" \
    .

podman save ghcr.io/ecnepsnai/nginx:${VERSION} > nginx:${VERSION}.tar
gzip nginx:${VERSION}.tar
