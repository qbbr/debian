#!/bin/bash

alias q='exit'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias xclip='xclip -sel clip'

if [ -x /usr/bin/dircolors ]; then
    alias l="ls -la --color --group-directories-first | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}'"
    alias ll="ls++"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    export GREP_COLOR="1;33"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias hi="history"
alias rm="rm -i"
alias v="vim"
alias vi="vim"
alias sv="sudo vim"
alias svi="sudo vim"
alias pong="ping -c 3 www.google.com"
alias exit="clear; exit"
alias dush="du -sm *|sort -n|tail"
alias skype='ALSA_OSS_PCM_DEVICE="skype" aoss skype'
