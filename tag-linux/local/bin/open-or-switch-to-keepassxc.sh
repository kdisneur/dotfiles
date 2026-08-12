#!/usr/bin/env bash

xdotool search --onlyvisible --limit 1 --class keepassxc windowactivate || exec keepassxc
