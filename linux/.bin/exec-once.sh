#!/usr/bin/env bash

className=${1:?class name is required};
cmdline=${2:?command to execute};
if [ -z "$(xdotool search --class "${className}")" ]; then
  exec ${cmdline}
fi
