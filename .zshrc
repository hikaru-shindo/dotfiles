export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME=""

plugins=(
  ssh-agent 
  git
  gitignore
  golang
  docker
  gradle
)

source ${ZSH}/oh-my-zsh.sh

if [[ -f ${HOME}/.zsh/zlocal ]]; then
  source ${HOME}/.zsh/zlocal
fi

#Star Ship
eval "$(starship init zsh)"
