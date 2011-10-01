#!/bin/bash

while true; do
    ev=`inotifywait -e create -e moved_to ~/Mail/*/*/new 2> /dev/null`
    pa=${ev/ */}
    f="$pa/${ev/* /}"
    bo=${pa/\/new/}
    bo=${bo/*Mail\//}
    # ~/sft/dwm/dzen/notify "New mail in $bo\n`grep -m 1 ^From: $f`\n`grep -m 1 ^Subject: $f | ~/scrpts/decode_mime_header`"
    notify-send -t 12000 -i '/usr/share/icons/oxygen/32x32/status/mail-unread-new.png' "New mail in $bo" "`grep -m 1 ^From: $ | sed 's/[<>]//g'`\n`grep -m 1 ^Subject: $f | ~/scrpts/decode_mime_header | sed 's/[<>]//g'`"
done
