#!/bin/bash

# Last tested on tumx version: 3.7

CURRENT_DIR=$PWD
CURRENT_SESSION=$(tmux display-message -p '#S')
NEW_SESSION="dev"
NEW_WINDOW="agents"
PLANNER_AGENT_PANE_NAME="planner_agent"
EXECUTOR_AGENT_PANE_NAME="executor_agent"
KILLALL=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --killall)
      KILLALL=true
      shift
      ;;
    *)
      echo "Unknown argument: $1" >&2
      shift
      ;;
  esac
done

init_layout() {
    local new_window=${1:$NEW_WINDOW}

    tmux set -p -t "$CURRENT_SESSION":"$new_window".0 @label "Planner Agent"
    tmux send-keys -t "$CURRENT_SESSION":"$new_window".0 "claude" C-m

    tmux split-window -h
    tmux set -p -t "$CURRENT_SESSION":"$new_window".1 @label "Executor Agent"
    tmux send-keys -t "$CURRENT_SESSION":"$new_window".1 "claude" C-m
    tmux select-pane -t "$CURRENT_SESSION":"$new_window".0
}

if $KILLALL; then
  echo "Killing other tmux sessions..."

  if [ -n "$TMUX" ]; then
    tmux kill-session -a
    tmux kill-pane -a
  else
    tmux kill-server
  fi

fi

if [ -n "$TMUX" ]; then
  CURRENT_WINDOW_NAME=$(tmux display-message -p '#W')
  TEMP_WINDOW="temp-$(date +%s)"
  LATEST_WINDOW_INDEX=$(tmux list-windows -F '#{window_index}' | sort -n | tail -n 1)
  NEW_WINDOW_INDEX=$(( ${LATEST_WINDOW_INDEX:-0} + 1 ))

  tmux new-window -t "$CURRENT_SESSION":"$NEW_WINDOW_INDEX" -n "$TEMP_WINDOW"
  init_layout "$NEW_WINDOW_INDEX"
  tmux rename-window -t "$CURRENT_SESSION":"$NEW_WINDOW_INDEX" "$NEW_WINDOW"
  tmux kill-window -a \; move-window -t 0
else
  tmux new-session -d -s "$NEW_SESSION" -n "$NEW_WINDOW"
  init_layout
  tmux attach-session -t "$NEW_SESSION"
fi
