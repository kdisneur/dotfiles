#!/usr/bin/env bash
#
# uv, plus a default interpreter for shells outside a project. Runs before
# 30-language-servers, which installs python-lsp-server with uv tool.

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"
source "${HOME}/.local/lib/update-system.bash"

PYTHON_VERSION="3.12";

# uv-dist, not uv: ~/.local/share/uv is uv's own data directory
UV_DIST="uv-dist";

is_externally_provided uv && exit 0

version="$(github_latest_tag astral-sh/uv)"
[ "$(managed_version "${UV_DIST}")" = "${version}" ] && exit 0

case "$(uname -m)" in
  x86_64) target="x86_64-unknown-linux-gnu";;
  aarch64) target="aarch64-unknown-linux-gnu";;
  *) log_fatal "no uv build known for $(uname -m)";;
esac

log_info "updating uv to ${version}"
tmp="$(mktemp -d)"
curl -fsSL "https://github.com/astral-sh/uv/releases/download/${version}/uv-${target}.tar.gz" \
  | tar -xz --strip-components=1 -C "${tmp}"

mkdir -p "${LOCAL_SHARE}/${UV_DIST}" "${LOCAL_BIN}"
mv "${tmp}/uv" "${tmp}/uvx" "${LOCAL_SHARE}/${UV_DIST}/"
ln -sf "${LOCAL_SHARE}/${UV_DIST}/uv" "${LOCAL_BIN}/uv"
ln -sf "${LOCAL_SHARE}/${UV_DIST}/uvx" "${LOCAL_BIN}/uvx"
rm -rf "${tmp}"

log_info "installing Python ${PYTHON_VERSION} as the default interpreter"
# --preview-features: names the experimental feature so --default stops warning
"${LOCAL_BIN}/uv" python install \
  --preview-features python-install-default \
  --default "${PYTHON_VERSION}"

stamp_managed_version "${UV_DIST}" "${version}"
