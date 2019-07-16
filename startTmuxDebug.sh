!#/bin/bash

tmux new-session -d -s session1
tmux rename-window 'debug gateway window'

tmux split-window -v
tmux select-pane -t 0
tmux send-keys 'sudo tcpdump -AUq -i lo port 1700' Enter
tmux split-window -h
tmux send-keys 'journalctl -f -n 100 -u doppl-gateway.service' Enter
tmux send-keys tmux select-pane -t 2
tmux send-keys 'mosquitto_sub -v -t "gateway/#" -h 172.105.0.73 -p 1883' Enter
tmux split-pane -h
tmux select-plane -t 3
tmux send-keys 'journalctl -f -n 100 -u lora-gateway-bridge.service' Enter


tmux attach-session -t session1 
