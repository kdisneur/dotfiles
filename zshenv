PATH="./bin:${PATH}"
PATH="${HOME}/.asdf/shims:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="/usr/local/sbin:${PATH}"
PATH="${HOME}/.bin.local:${PATH}"
PATH="${HOME}/.bin:${PATH}"

FPATH="${HOME}/.zsh/functions:${FPATH}"

export CDPATH="${CDPATH}:${HOME}/Workspace"
export DISABLE_AUTO_TITLE="true"
export DISPLAY=:1
export EDITOR=nvim
export FPATH
export GIT_EDITOR=nvim
export GITPR_EDITOR="nvim -c 'set ft=markdown'"
export GOPATH=~/Workspace/go
PATH="${PATH}:${GOPATH}/bin"
export HOMEBREW_BREWFILE=${HOME}/.brewfile
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --with-wx" # In order to not install Erlang with Java
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LYNX_LSS=$HOME/.lynx.lss
export PATH
export TERM=xterm-256color
export WORDCHARS='*?.[]~&;!#$%^(){}<>'
export TILLER_NAMESPACE=tiller
export HELM_TLS_ENABLE=true

export HISTFILE=${HOME}/.zhistory
export HISTSIZE=5000
export SAVEHIST=5000
