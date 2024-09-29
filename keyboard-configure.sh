#!/usr/bin/env bash

DISPLAY=":0"
HOME=/home/berin
XAUTHORITY=$HOME/.Xauthority

export DISPLAY XAUTHORITY HOME
xset r rate 200 60
xcape -e "#66=Escape"
setxkbmap -option 'caps:ctrl_modifier'
# notify-send "This notification is being shown!"
