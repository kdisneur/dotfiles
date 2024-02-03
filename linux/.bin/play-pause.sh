#!/usr/bin/env bash

suspendState=0;
if pacmd list-sinks | grep -q 'state: RUNNING'; then
  suspendState=1
fi
pacmd suspend ${suspendState}
