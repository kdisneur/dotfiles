export WORKSPACE=${HOME}/Workspace

PATH="/usr/local/bin:${PATH}"
PATH="${HOME}/.bin.local${PATH}"
PATH="${HOME}/.bin:${PATH}"
PATH="/usr/local/lib/python2.7/site-packages:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/.asdf/shims:${PATH}"
PATH="${HOME}/.tmuxifier/bin::${PATH}"
PATH="${PATH}:$(yarn global bin)"

export PATH
export DISPLAY=:1
export DISABLE_AUTO_TITLE="true"
export EDITOR=nvim
export GIT_EDITOR=nvim
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export BASE16_SHELL=$HOME/.config/base16-shell/

[ -n "$TMUX" ] && export TERM=screen-256color

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

alias serve="ruby -run -e httpd . -p 8000"
alias vim=nvim

[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
[[ -r ${HOME}/.asdf/asdf.sh ]] && source ${HOME}/.asdf/asdf.sh

# Has to be after rbenv to ensure binstubs has highest priority
export PATH="./bin:${PATH}"

export CDPATH="${CDPATH}:${HOME}/Workspace"
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
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

# Override zpresto configuration
alias cp='nocorrect cp'
alias ln='nocorrect ln'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
setopt CLOBBER

port_in_use() {
  lsof -n -i:${1} | grep LISTEN
}

tt() {
  echo -e "\033];$@\007"
}

current_tt() {
  tt $(basename $(pwd))
}

current_tt
