conky | while true; read line; do xsetroot -name "$line"; done &
feh --bg-scale /home/sokolov/.config/dwm.png &
#wbar -bpress -vbar -pos right -filter 2 -fc 0xffaaaaaa -zoomf 1.5 &
exec dwm
