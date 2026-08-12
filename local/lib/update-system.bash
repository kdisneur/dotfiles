# Helpers for update-system fragments.
#
# Fragments run as separate processes and inherit nothing, so they source this
# alongside std.bash:
#
#   source "${HOME}/.local/lib/std.bash"
#   source "${HOME}/.local/lib/update-system.bash"

LOCAL_BIN="${HOME}/.local/bin";
LOCAL_SHARE="${HOME}/.local/share";

# The latest release tag of a GitHub repository, eg "v0.11.0" for
# koalaman/shellcheck. Note that include-style globs are not involved: the
# GitHub API returns compact JSON, so the tag is pulled out textually.
github_latest_tag() {
  local repository="$1";

  curl -fsSL "https://api.github.com/repos/${repository}/releases/latest" \
    | grep -oE '"tag_name": *"[^"]*"' \
    | head -1 \
    | sed 's/.*: *"//; s/"$//';
}

# A tool is left alone when a package manager already provides it, so that brew
# or the distribution stays authoritative wherever it is in charge. Only copies
# we installed ourselves under ~/.local are managed here.
is_externally_provided() {
  local binary="$1" location="";

  location="$(command -v "${binary}" 2>/dev/null)" || return 1;

  case "${location}" in
    "${LOCAL_BIN}"/*) return 1;;
    *) return 0;;
  esac
}

# Version stamp of a tool we installed, used to skip downloads that would only
# reinstall what is already there.
managed_version() {
  local name="$1";

  cat "${LOCAL_SHARE}/${name}/.version" 2>/dev/null || echo "none";
}

stamp_managed_version() {
  local name="$1" version="$2";

  printf '%s\n' "${version}" > "${LOCAL_SHARE}/${name}/.version";
}
