export WORKSPACE=${HOME}/Workspace

PATH="./bin:${PATH}"
PATH="/usr/local/bin:${PATH}"
PATH="/usr/local/sbin:${PATH}"
PATH="${HOME}/.bin.local:${PATH}"
PATH="${HOME}/.bin:${PATH}"
PATH="${HOME}/.asdf/shims:${PATH}"
PATH="${HOME}/.tmuxifier/bin:${PATH}"

export BASE16_SHELL=${HOME}/.config/base16-shell/
export CDPATH="${CDPATH}:${HOME}/Workspace"
export DISABLE_AUTO_TITLE="true"
export DISPLAY=:1
export EDITOR=vim
export ELIXIR_EDITOR="vim +__LINE__ __FILE__"
export FPATH
export GIT_EDITOR=vim
export GPG_TTY=$(tty)
export HOMEBREW_BREWFILE=${HOME}/.brewfile
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH
export TERM=xterm-256color
export WORDCHARS='*?.[]~=&;!#$%^(){}<>'

export HISTFILE=${HOME}/.zhistory
export HISTSIZE=5000
export SAVEHIST=5000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

bindkey -e
bindkey '^[[1;9D' backward-word # Alt-Left
bindkey '^[[1;9C' forward-word # Alt-Right
bindkey '^[[3~' delete-char # Delete
bindkey '^[[Z' reverse-menu-complete # Ctrl-r
bindkey '^[[A' up-line-or-search # Arrow up
bindkey '^[[B' down-line-or-search # Arrow down

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
setopt PROMPT_SUBST
export PROMPT='%B%c%b %(?.(%F{198}♥%f‿%F{198}♥%f.(%F{75}ಥ%f_%F{75}ಥ%f)) '

[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
[[ -r ${HOME}/.asdf/asdf.sh ]] && source ${HOME}/.asdf/asdf.sh
[[ -r ${HOME}/.zcompletion ]] && source ${HOME}/.zcompletion
[[ -r ${HOME}/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ${HOME}/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -x ${HOME}/.bin/environment ]]; then
  source ${HOME}/.bin/environment
fi

alias ls='ls -G'
alias ll='ls -lh'
alias serve="ruby -run -e httpd . -p 8000"

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
