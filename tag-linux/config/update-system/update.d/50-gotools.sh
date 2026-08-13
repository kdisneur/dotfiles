#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

source "${HOME}/.local/lib/std.bash"

# exit, not return: update-system runs fragments with `bash "${f}"` rather than
# sourcing them, and return outside a function is an error that errexit turns
# into an aborted fragment.
command -v go &>/dev/null || exit 0

log_info "updating restish"
go install github.com/rest-sh/restish/v2/cmd/restish@latest
