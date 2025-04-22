#!/usr/bin/env bash

DISPLAY=":0"
HOME=/home/berin
XAUTHORITY=$HOME/.Xauthority

export DISPLAY XAUTHORITY HOME
xset r rate 200 45
# xset r rate 350 45
xcape -e "#66=Escape"
setxkbmap -option 'caps:ctrl_modifier'
# notify-send "This notification is being shown!"
