#!/usr/bin/env bash
#
# fzf.
#
# Linux only: on macOS the Brewfile owns fzf. That is why this lives under
# tag-linux instead of testing for brew at runtime, and why the download below
# can hardcode the linux asset.
#
# Deliberately not guarded by is_externally_provided either. Distributions ship
# fzf, and Ubuntu 22.04's is 0.29, far too old for the --color=base16 in
# FZF_DEFAULT_OPTS, so deferring to a system copy would reinstate the bug. What
# is installed below sits in ~/.local/bin, which precedes /usr/bin on PATH.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"
source "${HOME}/.local/lib/update-system.bash"

tag="$(github_latest_tag junegunn/fzf)"
version="${tag#v}"
[ "$(managed_version fzf)" = "${version}" ] && exit 0

log_info "updating fzf to ${version}"
tmp="$(mktemp -d)"
curl -fsSL "https://github.com/junegunn/fzf/releases/download/${tag}/fzf-${version}-linux_amd64.tar.gz" \
  | tar -xz -C "${tmp}"

mkdir -p "${LOCAL_SHARE}/fzf" "${LOCAL_BIN}"
mv "${tmp}/fzf" "${LOCAL_SHARE}/fzf/fzf"
ln -sf "${LOCAL_SHARE}/fzf/fzf" "${LOCAL_BIN}/fzf"
rm -rf "${tmp}"

stamp_managed_version fzf "${version}"
