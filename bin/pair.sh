#!/bin/sh

tmux -S /tmp/pair has-session -t workenv
if [[ $? == 1 ]] ; then
    pushd $(pwd)
    tmux -S /tmp/pair new-session -d -s workenv -n Vim
    tmux -S /tmp/pair new-window -t workenv -n Pairing
    popd
fi
tmux -S /tmp/pair -2 attach -t workenv
