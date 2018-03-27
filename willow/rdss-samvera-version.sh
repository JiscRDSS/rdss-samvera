#!/bin/bash

OUT_FILE=$1
COMMIT=$(git rev-parse HEAD)
TAG=$(git describe --abbrev=0 --tags --always)

if [[ $TAG == $COMMIT ]]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    SHORT_COMMIT=$(git rev-parse --short HEAD)
    OUTPUT="RDSS_SAMVERA_VERSION=\"$BRANCH @ $SHORT_COMMIT\""
else
    OUTPUT="RDSS_SAMVERA_VERSION=\"$TAG\""
fi

echo $OUTPUT > $OUT_FILE
