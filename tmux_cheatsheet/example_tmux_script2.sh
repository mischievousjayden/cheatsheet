#!/bin/bash

session_name=""
window_name=editor
work_dir=$HOME

while [ $# -ne 0 ] ; do
    arg="$1"
    case "$arg" in
        -s) session_name="$2"; shift;;
        -w) window_name="$2"; shift;;
        -d) work_dir="$2"; shift;;
    esac
    shift
done

if [ -z "$session_name" ]; then
    echo "No session_name"
    exit 1
fi

tmux has-session -t $session_name
if [ $? = 0 ]; then
    echo "session $session_name already exist"
    exit 1
fi

# create session 'development' and window 'editor' then detach
tmux new-session -s $session_name -n $window_name -d

# change directory, C-m is carriage return (tell tmux to press the enter key)
tmux send-keys -t $session_name "cd $work_dir" C-m

# open vim
tmux send-keys -t $session_name 'vim' C-m

# split window
# tmux split-window -v -p 10 -t development
tmux split-window -v -t $session_name
tmux select-layout -t $session_name main-horizontal

# change directory on pane2
tmux send-keys -t $session_name:1.2 "cd $work_dir" C-m

# create another window
tmux new-window -n console -t $session_name
tmux send-keys -t $session_name:2 "cd $work_dir" C-m

# select first window
tmux select-window -t $session_name:1
tmux select-pane -t 1
tmux attach -t $session_name

