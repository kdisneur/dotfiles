#! /usr/bin/env bash

root=$(cd $(dirname ${0}); pwd);

[[ ! -e /usr/local/bin/brew ]] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle check --file=${root}/Brewfile > /dev/null || brew bundle --file=${root}/Brewfile
