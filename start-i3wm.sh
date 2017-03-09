#!/bin/bash
i3-msg layout tabbed
killall redis-server
#mate-terminal -x bash -c "redis-server; $SHELL"
mate-terminal 
mate-terminal -x bash -c "mate-terminal -x bash -c 'redis-server; bash';bundle exec rails s; $SHELL"
vim -S mysession
#nohup mate-terminal
#nohup mate-terminal -x bash -e "redis server"
#nohup mate-terminal -x bash -e "bundle exec rails s"
