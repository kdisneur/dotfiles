#! /usr/bin/env bash

[[ ! -e ~/.config/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh-syntax-highlighting

[[ ! -e ~/.zsh/completion/_docker ]] && curl -fLo ~/.zsh/completion/_docker --create-dirs https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
[[ ! -e ~/.zsh/completion/_docker-compose ]] && curl -fLo ~/.zsh/completion/_docker-compose --create-dirs https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose
