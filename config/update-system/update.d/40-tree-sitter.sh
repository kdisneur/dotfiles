#!/usr/bin/env bash
#
# The CLI nvim-treesitter compiles parsers with. Built from source rather than
# taken from the releases: every published binary since 0.26.1 needs glibc 2.39,
# newer than Ubuntu 22.04 provides. The npm package is explicitly unsupported by
# the plugin. Needs the cargo installed by 20-rust.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"
source "${HOME}/.local/lib/update-system.bash"

is_externally_provided tree-sitter && exit 0

if ! command -v cargo &>/dev/null; then
  log_warn "skipping tree-sitter: no cargo to build it with"
  exit 0
fi

log_info "updating tree-sitter"
cargo install --quiet tree-sitter-cli
