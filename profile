PATH="${HOME}/.local/bin:${PATH}";
PATH="${HOME}/.local/bin/llvm:${PATH}";
PATH="${HOME}/.cargo/bin:${PATH}";
PATH="${HOME}/.go/bin:${PATH}";
PATH="./scripts:${PATH}";

export HISTFILE=${HOME}/.zsh_history;
export HISTSIZE=1000; # Number of entries to keep in memory
export SAVEHIST=1000; # Number of entries to keep on disk
export TMPDIR=${HOME}/tmp;
export CC=clang
export CXX=clang++
export CMAKE_C_COMPILER=clang
export CMAKE_CXX_COMPILER=clang++
export GOBIN=${HOME}/.go/bin
export GOPATH=${HOME}/.cache/go

export EDITOR=nvim;
export GIT_EDITOR=nvim;
export LANG=en_US.UTF-8;
export PATH;
export TERM=xterm-256color;
export WORDCHARS='*?.[]~&;!#$%^(){}<>';

export FZF_DEFAULT_OPTS="
  --color=base16
  --color=fg:8,bg:-1,hl:-1
  --color=fg+:-1:bold,bg+:-1,hl+:-1
  --color=border:red,header:-1,gutter:-1
  --color=spinner:bright-cyan,info:bright-cyan,separator:8
  --color=pointer:bright-yellow,marker:bright-red,prompt:bright-yellow"
