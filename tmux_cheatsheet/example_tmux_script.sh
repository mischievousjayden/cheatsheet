#!/bin/bash

tmux has-session -t development
if [ $? != 0 ]
then
    # create session 'development' and window 'editor' then detach
    tmux new-session -s development -n editor -d

    # change directory, C-m is carriage return (tell tmux to press the enter key)
    tmux send-keys -t development "cd ~/devproject" C-m

    # open vim
    tmux send-keys -t development 'vim' C-m

    # split window
    # tmux split-window -v -p 10 -t development
    tmux split-window -v -t development
    tmux select-layout -t development main-horizontal

    # change directory on pane2
    tmux send-keys -t development:1.2 "cd ~/devproject" C-m

    # create another window
    tmux new-window -n console -t development
    tmux send-keys -t development:2 "cd ~/devproject" C-m

    # select first window
    tmux select-window -t development:1
    tmux select-pane -t 1
fi
tmux attach -t development

