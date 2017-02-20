#!/bin/bash
tmux new-session -d -s basicauth
tmux new-window -t basicauth:2
tmux send-keys -t basicauth:2 "redis-server" "Enter"
tmux send-keys -t basicauth:1 "bundle exec rails s" "Enter"
tmux attach -t basicauth
tmux select-window -t basicauth:1
