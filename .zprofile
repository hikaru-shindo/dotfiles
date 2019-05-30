# Setup session
eval `dircolors $HOME/.dircolors`
if [[ -n $DISPLAY ]]; then setxkbmap us altgr-intl; fi

# Global variables
export PATH="${HOME}/bin:${PATH}"
export MAKEFLAGS="-j$(nproc)"

# Aliases
alias c="clear"
alias ls='ls --color=auto'
alias tmux='TERM=screen-256color-bce tmux'
alias vim='nvim'
alias doco="docker-compose"

