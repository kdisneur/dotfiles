#!/usr/bin/env bash
#
# Language servers for nvim, plus the linters they shell out to.
#
# Each toolchain installs its own; the rest are published only as release
# archives, unpacked under ~/.local/share and linked into ~/.local/bin. Those
# stand aside when a package manager already provides the tool, so brew stays
# authoritative on machines that have it.
#
# Note that shellcheck itself is not a language server: bash-language-server
# shells out to it. (This line must not begin with the word shellcheck, which
# would be read as a linter directive.)

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"
source "${HOME}/.local/lib/update-system.bash"

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

update_shellcheck() {
  local version="" archive="" tmp=""

  is_externally_provided shellcheck && return 0

  version="$(github_latest_tag koalaman/shellcheck)"
  [ "$(managed_version shellcheck)" = "${version}" ] && return 0

  log_info "updating shellcheck to ${version}"
  tmp="$(mktemp -d)"
  archive="shellcheck-${version}.linux.$(uname -m).tar.xz"
  curl -fsSL "https://github.com/koalaman/shellcheck/releases/download/${version}/${archive}" \
    | tar -xJ -C "${tmp}"

  mkdir -p "${LOCAL_SHARE}/shellcheck" "${LOCAL_BIN}"
  mv "${tmp}/shellcheck-${version}/shellcheck" "${LOCAL_SHARE}/shellcheck/shellcheck"
  ln -sf "${LOCAL_SHARE}/shellcheck/shellcheck" "${LOCAL_BIN}/shellcheck"
  rm -rf "${tmp}"

  stamp_managed_version shellcheck "${version}"
}

update_lua_language_server() {
  local version="" tmp=""

  is_externally_provided lua-language-server && return 0

  version="$(github_latest_tag LuaLS/lua-language-server)"
  [ "$(managed_version lua-language-server)" = "${version}" ] && return 0

  log_info "updating lua-language-server to ${version}"
  tmp="$(mktemp -d)"
  curl -fsSL "https://github.com/LuaLS/lua-language-server/releases/download/${version}/lua-language-server-${version}-linux-x64.tar.gz" \
    | tar -xz -C "${tmp}"

  # the binary resolves its own meta/ and main.lua relative to itself, so the
  # whole tree has to stay together and only the launcher gets linked
  rm -rf "${LOCAL_SHARE}/lua-language-server"
  mkdir -p "${LOCAL_SHARE}/lua-language-server" "${LOCAL_BIN}"
  mv "${tmp}"/* "${LOCAL_SHARE}/lua-language-server/"
  ln -sf "${LOCAL_SHARE}/lua-language-server/bin/lua-language-server" "${LOCAL_BIN}/lua-language-server"
  rm -rf "${tmp}"

  stamp_managed_version lua-language-server "${version}"
}

update_clangd() {
  local version="" tmp=""

  is_externally_provided clangd && return 0

  version="$(github_latest_tag clangd/clangd)"
  [ "$(managed_version clangd)" = "${version}" ] && return 0

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
}

update_go_tools
update_node_tools
update_python_tools
update_shellcheck
update_lua_language_server
update_clangd
