#!/bin/bash
SESSION=$USER

cd $HOME/notes
tmux -2 new-session -d -s $SESSION
tmux rename-window -t 0 'notes'

if [ ! command -v notes &> /dev/null ]; then
    notes
fi

cd $HOME
tmux new-window -t $SESSION:1 -n 'dev'
tmux run-shell "cd $HOME"
tmux split-window -v
tmux resize-pane -D 80
tmux select-pane -t 0
tmux split-window -h
tmux resize-pane -R 90

tmux -2 attach-session -t $SESSION
