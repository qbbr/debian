#!/bin/sh

# kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

# disable bell
xset -b

# chromium
#test -x /usr/bin/chromium-browser && /usr/bin/chromium-browser &

numlockx on &

# fix java bug
wmname LG3D &

# ~/.xbindkeysrc
xbindkeys &

# start urxvtd daemon
urxvtd -q -f -o &

# background image
feh --bg-center ~/dwm.png

# top right tray
trayer --expand true --widthtype request --transparent true --alpha 0 --tint 0x101010 --edge top --align right --height 18 --margin 216 &

# clipboard
parcellite &

# conky + dzen2
#~/scrpts/dzconky &

# dzen
~/sft/dwm/dzen/startdzen &

# email notifier
~/scrpts/email_notifier.sh

# dropbox
~/.dropbox-dist/dropbox &

urxvtc &
#urxvt -e rtorrent &

# xinerama
#DISPLAY=:0.0 dwm &
#DISPLAY=:0.1 dwm

~/sft/dwm/dwm/startdwm
