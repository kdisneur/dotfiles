#!/usr/bin/env bash
#
# Plugins and treesitter parsers. Runs last: the parser update shells out to the
# tree-sitter CLI installed by 40-tree-sitter.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"

command -v nvim &>/dev/null || exit 0

log_info "updating nvim packages"
nvim --headless "+Lazy! sync" +qa
nvim --headless -c "lua require('nvim-treesitter.install').update():wait(300000)" +qa
