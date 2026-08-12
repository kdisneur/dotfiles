#!/usr/bin/env bash

xdotool search --onlyvisible --limit 1 --class firefox windowactivate || exec firefox
