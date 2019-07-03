#! /usr/bin/env bash

root=$(cd $(dirname ${0}); pwd);

mkdir -p ~/Library/Application\ Support/Spectacle/
ln -fs ${root}/spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json
