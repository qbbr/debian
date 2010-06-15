#!/bin/sh

# random  wallpapers

DIR="/media/HDD_2/wallpapers"

while true; do
	feh --bg-center "$(find $DIR -name *.jpg | shuf -n 1)"
	sleep 15m
done &
