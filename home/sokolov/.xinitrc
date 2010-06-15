# ~/.xinitrc

conky | while true; read line; do xsetroot -name "$line"; done &
#exec feh --bg-center /media/hdd2/wallpapers/80\ Sexy\ Girls\ Models\ and\ Celebrities\ Wallpapers/10_1080p.jpg &
#exec /home/sokolov/scrpts/fehbg.sh &
exec ~/scrpts/startdwm
