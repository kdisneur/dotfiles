#! /usr/bin/env bash

root=$(cd $(dirname ${0}); pwd);

mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
ln -fs ${root}/iterm.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/default.json
