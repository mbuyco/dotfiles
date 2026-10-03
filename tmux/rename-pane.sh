#!/bin/zsh -f
# Rename the current tmux pane, starting from an empty input.
# Enter on an empty input, Escape or Ctrl-C keeps the current title.
#
# Bind in ~/.tmux.conf:
#   bind T run-shell "~/dotfiles/tmux/rename-pane.sh"

if [[ $1 == --prompt ]]; then
  zmodload zsh/zle
  KEYTIMEOUT=1
  bindkey -e
  bindkey '^[' send-break
  title=''
  vared -p 'Pane title: ' title || exit 0
  [[ -n $title ]] && tmux set -p -t "$2" @label "$title"
  exit 0
fi

pane="$(tmux display-message -p '#{pane_id}')"
tmux display-popup -E -w 60 -h 3 -T " Rename pane " "zsh -f '$0' --prompt '$pane'"
exit 0
