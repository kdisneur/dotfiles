#!/usr/bin/env bash

xdotool search --limit 1 --class kitty windowactivate || exec kitty
