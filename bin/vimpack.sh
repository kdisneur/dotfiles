#! /usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

export VIMPATH=${VIMPATH:-"${HOME}/.vim"};
export PACKPATH=${VIMPATH}/pack;

_currentBackends=vim;
_currentNamespaceName=;
_vimpackFile=${VIMPATH}/plugins.vimpack;

_clone() {
  local kind=${1};
  local repository=${2};
  local githubURL=git@github.com:${repository};

  local folder=$(_currentNamespace)/${kind};
  if [ -d ${folder}/$(basename ${repository}) ]; then
    git -C ${folder}/$(basename ${repository}) pull --quiet;
  else
    mkdir -p ${folder};
    git -C ${folder} clone --quiet ${githubURL};
  fi
}

_currentNamespace() {
  if [ -z "${_currentNamespaceName}" ]; then
    _error "current namespace is missing";
  fi

  echo ${PACKPATH}/${_currentNamespaceName};
}

_error() {
  >&2 echo "$(tput setaf 1)${*}$(tput sgr0)";
  return 1;
}

backend() {
  _currentBackends=${*};
}

namespace() {
  local name=${1};

  echo "switching to namespace ${name}";

  _currentNamespaceName=${name};
}

onstart() {
  local repository=${1};

  echo "installing/updating start package: ${repository}"
  _clone "start" "${repository}";
}

ondemand() {
  local repository=${1};

  echo "installing/updating optional package: ${repository}"
  _clone "opt" "${repository}";
}

run() {
  local backends=${1};
  shift;
  local commands=${*};
  if [ "${backends}" = "_" ]; then
    local backends=${_currentBackends};
  fi

  for backend in ${backends}; do
    vimCommands=""
    for command in ${commands}; do
      vimCommands="${vimCommands} +${command}";
    done

    ${backend} ${vimCommands} +qa
  done
}

if [ -f ${_vimpackFile} ]; then
  while read line; do
    eval ${line};
  done <${_vimpackFile};
else
  _error "can't find vimpack file: ${_vimpackFile}";
  exit 1;
fi
