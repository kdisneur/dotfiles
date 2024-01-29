PATH="${HOME}/Workspaces/go/bin:${PATH}";
PATH="${HOME}/.bin:${PATH}";

export HISTFILE=${HOME}/.zsh_history;
export HISTSIZE=1000; # Number of entries to keep in memory
export SAVEHIST=1000; # Number of entries to keep on disk

export EDITOR=nvim;
export GIT_EDITOR=nvim;
export GOPATH=${HOME}/Workspaces/go;
export LANG=en_US.UTF-8;
export LC_ALL=en_US.UTF-8;
export PATH;
export STOW_DIR=${HOME}/Workspaces/kdisneur/dotfiles;
export TERM=xterm-256color;
export WORDCHARS='*?.[]~&;!#$%^(){}<>';

source "${HOME}/.cargo/env"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#171421,bg:#eeeeee,hl:#005f87
 --color=fg+:#eeeeee,bg+:#005f87,hl+:#eeeeee
 --color=info:#afaf87,prompt:#005f87,pointer:#eeeeee
 --color=marker:#eeeeee,spinner:#005f87,header:#005f87';
