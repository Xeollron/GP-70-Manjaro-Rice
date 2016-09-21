#!/bin/bash

i3PID=$(pgrep i3)
 if [[ "$?" -eq 0 ]]; then
   kill $i3PID
   xfconf-query -c xfce4-panel -p /panels/panel-0/plugin-ids -t int -s 8 -t int -s 2 -t int -s 7 -t int -s 6 -t int -s 9 -t int -s 5 --create
   xfce4-panel -r
   xfwm4 &
   disown
 else
   pkill xfwm4 && i3 &
   xfconf-query -c xfce4-panel -p /panels/panel-0/plugin-ids -t int -s 8 -t int -s 2 -t int -s 7 -t int -s 1 -t int -s 6 -t int -s 9 -t int -s 5 --create
   xfce4-panel -r
   disown
 fi
