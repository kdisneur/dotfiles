#! /usr/bin/env bash

if [[ ! -e ~/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  pushd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  popd
fi

if [[ -e ~/.tool-versions ]]; then
  cut -f 1 -d ' ' ~/.tool-versions | xargs -L1 asdf plugin-add
  asdf install
fi
