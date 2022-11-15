if [ -x "$(command -v dircolors)" ]; then eval `dircolors $HOME/.dircolors`; fi
if [[ -n $DISPLAY ]]; then setxkbmap us altgr-intl; fi
