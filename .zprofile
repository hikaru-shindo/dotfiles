# Setup session

if [ -x "$(command -v dircolors)" ]; then eval `dircolors $HOME/.dircolors`i; fi
if [[ -n $DISPLAY ]]; then setxkbmap us altgr-intl; fi

# Global variables
export PATH="${HOME}/bin:${PATH}"

if [ -x "$(command -v nproc)" ]; then
  export MAKEFLAGS="-j$(nproc)"
fi

if [ -x "$(command -v gnome-terminal)" ]; then
  export TERMINAL="gnome-terminal"
fi

# Aliases
alias c="clear"
alias doco="docker-compose"
alias up="update-repos"
