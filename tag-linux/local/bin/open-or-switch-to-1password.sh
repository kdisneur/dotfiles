#!/usr/bin/env bash

xdotool search --onlyvisible --limit 1 --class 1password windowactivate || exec 1password
