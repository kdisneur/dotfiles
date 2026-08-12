#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"

command -v brew &>/dev/null || exit 0

log_info "updating brew packages"
brew update
brew upgrade
brew bundle dump --force --file "${HOME}/.local/state/update-system/Brewfile"
