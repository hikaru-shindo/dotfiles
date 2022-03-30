# Setup session

if [ -x "$(command -v dircolors)" ]; then eval `dircolors $HOME/.dircolors`i; fi
if [[ -n $DISPLAY ]]; then setxkbmap us altgr-intl; fi

# Global variables
export PATH="${HOME}/bin:/usr/local/sbin:${PATH}"

export KUBE_PS1_SYMBOL_DEFAULT="⎈ "

if [ -x "$(command -v nproc)" ]; then
  export MAKEFLAGS="-j$(nproc)"
fi

if [ -x "$(command -v gnome-terminal)" ]; then
  export TERMINAL="gnome-terminal"
fi

# Setup homebrew environment if needed
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_CASK_OPTS=--require-sha
  export HOMEBREW_NO_ANALYTICS=1
fi

# Setup brew java if needed
if [ -d /opt/homebrew/opt/openjdk/bin ]; then
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi

# Aliases
alias c="clear"
alias doco="docker compose"
alias up="update-repos"
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias curltime='curl -o /dev/null -s -w "    time_namelookup:  %{time_namelookup}s
       time_connect:  %{time_connect}s
    time_appconnect:  %{time_appconnect}s
   time_pretransfer:  %{time_pretransfer}s
      time_redirect:  %{time_redirect}s
 time_starttransfer:  %{time_starttransfer}s
                    ----------
         time_total:  %{time_total}s\n"'

# Activate karn if installed
if which karn > /dev/null; then eval "$(karn init)"; fi
