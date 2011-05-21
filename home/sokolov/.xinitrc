# ~/.xinitrc

xset -b # disable bell

conky | while true; read line; do xsetroot -name "$line"; done &
#exec feh --bg-center /media/strg2/wallpapers/catcat.jpg &
#exec ~/scrpts/fehbg.sh &
numlockx on &
exec feh --bg-center /media/strg2/wallpapers/a33/1.png &
exec wmname LG3D &
exec xbindkeys &
#exec ~/.dropbox-dist/dropboxd &
exec ~/scrpts/startdwm
#DISPLAY=:0.0 dwm &
#DISPLAY=:0.1 dwm
