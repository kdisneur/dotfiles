export WORKSPACE=${HOME}/Workspace

PATH="/usr/local/bin:${PATH}"
PATH="${HOME}/.bin.local${PATH}"
PATH="${HOME}/.bin:${PATH}"
PATH="/usr/local/lib/python2.7/site-packages:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="$HOME/.asdf/shims:${PATH}"

export PATH
export DISPLAY=:1
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

[ -n "$TMUX" ] && export TERM=screen-256color

alias e="emacsclient -t -a ''"
alias vi=e
alias vim=e
alias tmc="tmux new-session -s $1"
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"
alias serve="ruby -run -e httpd . -p 8000"

[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
[[ -r ${HOME}/.asdf/asdf.sh ]] && source ${HOME}/.asdf/asdf.sh

# Has to be after rbenv to ensure binstubs has highest priority
export PATH="./bin:${PATH}"

export CDPATH="${CDPATH}:${HOME}/app"
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
