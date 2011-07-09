# ~/.xinitrc

# Kill X with C-A-BS
setxkbmap -option terminate:ctrl_alt_bksp

xset -b # disable bell

#test -x /usr/bin/chromium && /usr/bin/chromium &

#~/scrpts/fehbg.sh &
numlockx on &
wmname LG3D &
xbindkeys &
urxvtd -q -f -o # start urxvtd daemon
feh --bg-center /media/strg2/wallpapers/cats/79117-1920x1080.jpg &

#conky | while true; read line; do xsetroot -name "$line"; done &
~/scrpts/dzconky &
checkgmail -no_cookies &
urxvt &
#urxvt -e rtorrent &

~/scrpts/startdwm
#DISPLAY=:0.0 dwm &
#DISPLAY=:0.1 dwm
