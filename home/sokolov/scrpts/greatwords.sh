#/bin/sh

echo 'Random quote from http://greatwords.ru'
wget -qO - http://greatwords.ru/random/ | sed -ne '/quote-p\|info-p/!b;s/<[^>]*>//g;s/&nbsp;/ /g;s/&hellip;/.../g;p' | fold -sw 160
