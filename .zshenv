# Variables
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"

# Aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
alias c="clear"
alias doco="docker-compose"

alias gswm='git switch master'
alias gswd='git switch develop'
alias grbom='git rebase origin/master'
alias wmip='echo IPv4 && curl "https://api.ipify.org/?format=plain" && echo && echo IPv6 && curl "https://api6.ipify.org/?format=plain"'
