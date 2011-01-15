#!/bin/bash
#
# pop-up calendar for dzen
#
# (c) 2007, by Robert Manea
#

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

(
echo '^bg(grey70)^fg(#111111)'`date +'%A, %d.%m.%Y %H:%M'`; echo

# current month, hilight header and today
cal \
    | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(white)\1/;s/(^|[ ])($TODAY)($|[ ])/\1^bg(white)^fg(#111111)\2^fg()^bg()\3/"

# next month, hilight header
cal `expr $MONTH + 1` $YEAR \
    | sed -e 's/^\(.*[A-Za-z][A-Za-z]*.*\)$/^fg(white)\1/'

sleep 60
) \
    | dzen2 -fn '-*-*-*-*-*-*-28-*-*-*-*-*-iso10646-*' -x 400 -y 60 -w 400 -l 18 -sa c -e 'onstart=uncollapse;button3=exit'