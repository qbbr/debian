#!/bin/bash
# @using makeSound.sh [CARD] > ~/.asoundrc
if default_card="${1:-$(cat "$(for f in $(ls -1 /proc/asound/card[0-9]*/{midi,codec}* 2>/dev/null); do echo "${f%/*}"; done \
| sed -e '\|^[\[:blank:]\]$|d' -e 'q')/id" 2>/dev/null)}"; then
   echo "Using sound card: ${default_card}" >&2 
   cat /proc/asound/card[0-9]*/id | \
   gawk --assign default_card="${default_card}" \
'{print "pcm."$1" { type hw; card "$1"; }\nctl."$1" { type hw; card "$1"; }" }
END {print "pcm.!default pcm."default_card"\nctl.!default ctl."default_card}'
else
   echo "Warning: No sound cards found." >&2
fi
