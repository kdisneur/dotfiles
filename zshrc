export WORKSPACE=${HOME}/app
export ZSH=/Users/work/.oh-my-zsh
plugins=(git)

PATH="/usr/local/bin:${PATH}"
PATH="${HOME}/.bin.local${PATH}"
PATH="${HOME}/.bin:${PATH}"
PATH="/usr/local/lib/python2.7/site-packages:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/.rbenv/bin:${PATH}"
PATH="$HOME/.rbenv/shims:${PATH}"

export PATH

export CDPATH="${CDPATH}:${HOME}/app"

export DISPLAY=:1
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

alias vi=vim
alias vim=nvim
alias tmc="tmux new-session -s $1"
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"
alias serve="ruby -run -e httpd . -p 8000"

[[ -r ${WORKSPACE}/others/liquidprompt/liquidprompt ]] && source ${WORKSPACE}/others/liquidprompt/liquidprompt
[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local

eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
