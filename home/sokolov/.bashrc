export TERM=xterm-256color        # for common 256 color terminals (e.g. gnome-terminal)
#export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session

# bash options
shopt -s autocd         # change to named directory
#shopt -s cdable_vars    # if cd arg is not valid, assumes its a var defining a dir
#shopt -s cdspell        # autocorrects cd misspellings
shopt -s checkwinsize   # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # include dotfiles in pathname expansion
shopt -s expand_aliases # expand aliases
shopt -s extglob        # enable extended pattern-matching features
shopt -s histappend     # append to (not overwrite) the history file
shopt -s hostcomplete   # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob     # pathname expansion will be treated as case-insensitive

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "$USER" == "root" ]; then
    user_color="31m"
else
    user_color="36m"
fi
PS1="┌─[\[\e[44m\]\h\e[0m\]:\e[${user_color}\]\u\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "
unset user_color

# set vim as default editor
export EDITOR="vim"
export FCEDIT="vim"
export VISUAL=$EDITOR

# set default browser
if [ -z "$DISPLAY" ]; then
    export BROWSER="links"
else
    export BROWSER="chromium-browser"
fi

# set history variables
export HISTFILESIZE="1000"
export HISTCONTROL="ignoredups"

# share history across all terminals
PROMPT_COMMAND="history -a"

# bash completion
set show-all-if-ambiguous on

# ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ~/.bash_functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# symfony2 console
if [ -e ~/symfony2-autocomplete.bash ]; then
    . ~/symfony2-autocomplete.bash
fi

# less colors for man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # начало мерцающего стиля
export LESS_TERMCAP_md=$'\E[01;38;5;11m'  # начало полужирного стиля
export LESS_TERMCAP_me=$'\E[0m'           # окончание мерцающего или полужирного стиля
export LESS_TERMCAP_so=$'\E[38;5;246m'    # начало служебной информации
export LESS_TERMCAP_se=$'\E[0m'           # окончание служебной информации
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # начало подчеркивания
export LESS_TERMCAP_ue=$'\E[0m'           # окончание подчеркивания
