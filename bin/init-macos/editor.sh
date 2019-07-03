#! /usr/bin/env bash

[[ ! -e ~/.vim/autoload/plug.vim ]] && curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qa
vim +PlugInstall +qa
