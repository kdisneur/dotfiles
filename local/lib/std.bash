_COLOR_ERROR="\033[38;5;1m";
_COLOR_SUCCESS="\033[38;5;2m";
_COLOR_WARNING="\033[38;5;3m";
_COLOR_RESET="\033[m";

_log() {
  local color="$1" color_reset="";
  shift;
  local message="$@";
  [ "${color}" ] && color_reset="${_COLOR_RESET}";

  printf "${color}%s${color_reset}\n" "${message}";
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
  local color="" message="$*";
  [ -t 2 ] && color="${_COLOR_ERROR}";

  >&2 _log "${color}" "${message}";
}

log_warn() {
  local color="" message="$@";
  [ -t 1 ] && color="${_COLOR_WARNING}";

  _log "${color}" "${message}";
}

log_success() {
  local color="" message="$@";
  [ -t 1 ] && color="${_COLOR_SUCCESS}";

  _log "${color}" "${message}";
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

help() {
  local script=$0;
  sed -ne '/^# /,/^$/{/^$/q;s/^# //p}' "${script}"
}
