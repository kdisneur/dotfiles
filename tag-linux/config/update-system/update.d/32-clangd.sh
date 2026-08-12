#!/usr/bin/env bash
#
# clangd, from the LLVM release rather than a package.
#
# Deliberately not guarded by is_externally_provided: the point is to track the
# latest clang tooling, which distributions lag behind, so deferring to a
# packaged clangd would defeat it. What is installed below sits in
# ~/.local/bin, which precedes /usr/bin on PATH.
#
# Linux only for now; the macOS asset is named differently and will be added
# when a Mac needs it.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"
source "${HOME}/.local/lib/update-system.bash"

version="$(github_latest_tag clangd/clangd)"
[ "$(managed_version clangd)" = "${version}" ] && exit 0

log_info "updating clangd to ${version}"
tmp="$(mktemp -d)"
curl -fsSL -o "${tmp}/clangd.zip" \
  "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip"
unzip -q "${tmp}/clangd.zip" -d "${tmp}"

rm -rf "${LOCAL_SHARE}/clangd"
mkdir -p "${LOCAL_SHARE}/clangd" "${LOCAL_BIN}"
mv "${tmp}/clangd_${version}"/* "${LOCAL_SHARE}/clangd/"
ln -sf "${LOCAL_SHARE}/clangd/bin/clangd" "${LOCAL_BIN}/clangd"
rm -rf "${tmp}"

stamp_managed_version clangd "${version}"
