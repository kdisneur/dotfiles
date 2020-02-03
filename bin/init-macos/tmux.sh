#! /usr/bin/env bash

if [[ ! -e ~/.tmux/plugin/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

~/.tmux/plugins/tpm/bin/install_plugins
