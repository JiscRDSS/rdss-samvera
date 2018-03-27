#!/bin/bash

COMMIT=$(git rev-parse HEAD)
TAG=$(git describe --abbrev=0 --tags --always)

if [[ $TAG == $COMMIT ]]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    SHORT_COMMIT=$(git rev-parse --short HEAD)
    OUTPUT="$BRANCH @ $SHORT_COMMIT"
else
    OUTPUT="$TAG"
fi

echo $OUTPUT
