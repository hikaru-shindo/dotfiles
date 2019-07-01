# Setup session
eval `dircolors $HOME/.dircolors`
if [[ -n $DISPLAY ]]; then setxkbmap us altgr-intl; fi

# Global variables
export PATH="${HOME}/bin:${PATH}"
export MAKEFLAGS="-j$(nproc)"

if [ -x /usr/bin/gnome-terminal ]; then
  export TERMINAL="gnome-terminal"
fi

# Aliases
alias c="clear"
alias ls='ls --color=auto'
alias tmux='TERM=screen-256color-bce tmux'
alias doco="docker-compose"

