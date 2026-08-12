#!/usr/bin/env bash
#
# Rust toolchain. Runs before tree-sitter, which is built with cargo.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"

if ! command -v rustup &>/dev/null; then
  log_info "installing rustup"
  # --no-modify-path: the profile files are dotfiles, rustup must not edit them
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

log_info "updating rustup"
rustup update
rustup component add rust-analyzer
