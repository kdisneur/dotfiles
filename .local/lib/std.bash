_COLOR_ERROR=$(tput setaf 1);
_COLOR_SUCCESS=$(tput setaf 2);
_COLOR_WARNING=$(tput setaf 3);
_COLOR_RESET=$(tput sgr0);

_log() {
  local color="$1";
  shift;
  local message="$@";

  printf "%s%s%s\n" "${color}" "${message}" "${_COLOR_RESET}";
}

log_fatal() {
  local message="$@";
  log_error "${message}";
  exit 1;
}

log_info() {
  local message="$*";
  _log "" "${message}";
}

log_error() {
  local message="$*";
  >&2 _log "${_COLOR_ERROR}" "${message}";
}

log_warn() {
  local message="$@";
  _log "${_COLOR_WARNING}" "${message}";
}

log_success() {
  local message="$@";
  _log "${_COLOR_SUCCESS}" "${message}";
}

yesno() {
  local question="$@";
  local answer="";

  while [ "${answer}" != "y" -a "${answer}" != "n" ]; do
    printf "%s (y/n) " "$question";
    read answer;
  done

  [ "${answer}" = "y" ];
}
