#! /usr/bin/env bash

GOMOD_FILE_PATH=${GOMOD_FILE_PATH:-go.mod};

if [ -e ${GOMOD_FILE_PATH} ]; then
  awk '/^module / { print $2 }' ${GOMOD_FILE_PATH};
fi
