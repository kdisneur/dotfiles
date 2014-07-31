WORKSPACE=${HOME}/app
ZSH=${HOME}/.oh-my-zsh

plugins=(git ruby)
source ${ZSH}/oh-my-zsh.sh

PATH="/usr/local/bin:${HOME}/.bin.local:${HOME}/.bin:${PATH}"
PATH="/usr/local/lib/python2.7/site-packages:${PATH}"
PATH="${HOME}/app/others/powerline/scripts:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="${PATH}:/opt/vagrant_ruby/bin"
PATH="${HOME}/.rbenv/bin:$HOME/.rbenv/shims:${PATH}"
export PATH="/usr/local/heroku/bin:${PATH}"

export DISPLAY=:1
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export POWERLINE_COMMAND='powerline -t default.segment_data.email_imap_alert.args.username="${POWERLINE_IMAP_EMAIL}" -t default.segment_data.email_imap_alert.args.password="${POWERLINE_IMAP_PASSWORD}"'
export TERM=xterm-256color

alias vi=vim

[[ -r ${WORKSPACE}/others/liquidprompt/liquidprompt ]] && source ${WORKSPACE}/others/liquidprompt/liquidprompt
[[ -r ${HOME}/.travis/travis.sh ]] && source ${HOME}/.travis/travis.sh
[ -s ${HOME}/.nvm/nvm.sh ] && source ${HOME}/.nvm/nvm.sh
[[ -r ${NVM_DIR}/bash_completion ]] && source ${NVM_DIR}/bash_completion
[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
[[ -r ${HOME}/.bin/tmuxinator.zsh ]] && source ${HOME}/.bin/tmuxinator.zsh
eval "$(rbenv init -)"
