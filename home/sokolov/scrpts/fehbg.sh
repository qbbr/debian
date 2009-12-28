#!/bin/sh
# rnd wallpapers
while true;
do
   feh --bg-center "$(find /media/hdd2/wallpapers -name *.jpg | shuf -n 1)"
   sleep 15m
done &
