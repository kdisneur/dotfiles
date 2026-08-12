#!/usr/bin/env bash
#
# Language servers that a toolchain installs for itself, so this works the same
# on every machine.
#
# The ones published only as release archives are not here: they are
# platform-specific and their staleness varies per distribution, so each lives
# in the tag of the machine that actually needs a hand-installed copy.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"

update_go_tools() {
  command -v go &>/dev/null || return 0

  log_info "updating go tools"
  go install golang.org/x/tools/gopls@latest
  go install github.com/nametake/golangci-lint-langserver@latest
}

update_node_tools() {
  command -v npm &>/dev/null || return 0

  log_info "updating node tools"
  npm install --global --no-fund --no-audit bash-language-server
}

update_python_tools() {
  command -v pipx &>/dev/null || return 0

  log_info "updating python tools"
  pipx upgrade python-lsp-server || pipx install python-lsp-server
}

update_go_tools
update_node_tools
update_python_tools
