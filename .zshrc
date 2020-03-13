# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="pnitsche"

plugins=(
  ssh-agent 
  git
  archlinux
  debian
  docker
  docker-compose
  helm
  kubectl
  minikube
  mvn
  gradle
  sudo
  rsync
  salt
  terraform
)

source ${ZSH}/oh-my-zsh.sh

# Set iterm2 bindings if needed
if [[ $(which bindkey) ]]; then
  bindkey "[D" backward-word
  bindkey "[C" forward-word
fi

if [[ -f ${HOME}/.zlocal ]]; then
  source ${HOME}/.zlocal
fi

