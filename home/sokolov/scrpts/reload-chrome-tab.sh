#!/bin/sh

WID=`xdotool search --onlyvisible --name "chromium" | head -1`
xdotool windowactivate $WID
xdotool key F5
