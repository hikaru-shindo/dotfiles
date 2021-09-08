# Halper functions
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
}

# Variables
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"

# Aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
alias c="clear"
alias doco="docker-compose"

alias gswm='git switch $(git_main_branch)'
alias gswd='git switch develop'
alias grbom='git rebase origin/$(git_main_branch)'
alias wmip='echo IPv4 && curl "https://api.ipify.org/?format=plain" && echo && echo IPv4/6 && curl "https://api64.ipify.org/?format=plain"'
