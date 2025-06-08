# added due to CodeCrafters C
export VCPKG_ROOT="${HOME}/Workspaces/github.com/microsoft/vcpkg";
PATH="${VCPKG_ROOT}:${PATH}";

PATH="${HOME}/.local/bin:${PATH}";
PATH="${HOME}/.cargo/bin:${PATH}";
PATH="./scripts:${PATH}";

export HISTFILE=${HOME}/.zsh_history;
export HISTSIZE=1000; # Number of entries to keep in memory
export SAVEHIST=1000; # Number of entries to keep on disk
export TMPDIR=${HOME}/tmp;
export CC=clang
export CXX=clang++
export CMAKE_C_COMPILER=clang
export CMAKE_CXX_COMPILER=clang++

export EDITOR=nvim;
export GIT_EDITOR=nvim;
export LANG=en_US.UTF-8;
export LC_ALL=en_US.UTF-8;
export PATH;
export TERM=xterm-256color;
export WORDCHARS='*?.[]~&;!#$%^(){}<>';

 export FZF_DEFAULT_OPTS="
 	--color=fg:#B7B5AC,bg:#FFFCF0,hl:#100F0F
 	--color=fg+:#B7B5AC,bg+:#F2F0E5,hl+:#100F0F
 	--color=border:#AF3029,header:#100F0F,gutter:#FFFCF0
 	--color=spinner:#3AA99F,info:#3AA99F,separator:#F2F0E5
 	--color=pointer:#D0A215,marker:#D14D41,prompt:#D0A215"
