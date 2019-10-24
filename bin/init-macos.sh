#! /usr/bin/env bash

root=$(cd $(dirname ${0}); pwd);

echo "Install brew..."
${root}/init-macos/brew.sh

echo "Install asdf and plugins..."
${root}/init-macos/asdf.sh

echo "Install zsh..."
${root}/init-macos/zsh.sh

echo "Install tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "Install editors..."
${root}/init-macos/editor.sh

echo "Install elixir LSP..."
${root}/init-macos/elixir-lsp.sh

echo "Setup MacOS preferences..."
${root}/init-macos/preferences.sh

echo "Setup spectacle shortcuts..."
${root}/init-macos/spectacle.sh

echo "Setup iTerm preferences..."
${root}/init-macos/iterm.sh

echo "Logout to have everything re-applied properly"
echo "Don't forget to set the default profile on iTerm"
