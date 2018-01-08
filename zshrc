export WORKSPACE=${HOME}/Workspace

PATH="./bin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="${HOME}/.bin.local:${PATH}"
PATH="${HOME}/.bin:${PATH}"
PATH="${HOME}/.asdf/shims:${PATH}"
PATH="${HOME}/.tmuxifier/bin:${PATH}"

export BASE16_SHELL=$HOME/.config/base16-shell/
export CDPATH="${CDPATH}:${HOME}/Workspace"
export DISABLE_AUTO_TITLE="true"
export DISPLAY=:1
export EDITOR=vim
export ELIXIR_EDITOR="vim +__LINE__ __FILE__"
export GIT_EDITOR=vim
export GPG_TTY=$(tty)
export HOMEBREW_BREWFILE=$HOME/.brewfile
export LC_ALL=en_US.UTF-8
export PATH
export TERM=xterm-256color

[ -n "$TMUX" ] && export TERM=screen-256color

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
[[ -r ${HOME}/.asdf/asdf.sh ]] && source ${HOME}/.asdf/asdf.sh

alias ls='ls -G'
alias ll='ls -lh'
alias serve="ruby -run -e httpd . -p 8000"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  setopt PROMPT_SUBST
  export PROMPT='%B%c%b %(?.(%F{198}♥%f‿%F{198}♥%f.(%F{75}ಥ%f_%F{75}ಥ%f)) '
fi

if [[ -x ${HOME}/.bin/environment ]]; then
  source ${HOME}/.bin/environment
fi

if [[ -x ${HOME}/.tmuxifier/bin/tmuxifier ]]; then
  eval "$(tmuxifier init -)"

  alias tmc="tmuxifier load-session $1"
  alias tma="tmc"
  alias tml="tmux list-sessions"
  alias tmk="tmux kill-session -t $1"
else
  alias tmc="tmux new-session -s $1"
  alias tma="tmux -2 attach -t $1"
  alias tml="tmux list-sessions"
  alias tmk="tmux kill-session -t $1"
fi

cdroot() {
  cd $(git root)
}

current_tt() {
  tt $(basename $(pwd))
}

port_in_use() {
  lsof -n -i:${1} | grep LISTEN
}

theme() {
  if [ -z "$1" ]; then
    echo "Argument is missing" >&2
    echo "Usage: $(basename $0) (dark|light)" >&2
    return 1
  fi

  if [ $1 = "dark" ]; then
    base16_gruvbox-dark-medium
  elif [ $1 = "light" ]; then
    base16_summerfruit-light
  fi
}

tt() {
  echo -ne "\033];$@\007"
}

current_tt
