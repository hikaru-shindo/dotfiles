# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="pnitsche"

plugins=(
  ssh-agent 
  git
  gitignore
  golang
  archlinux
  debian
  docker
  docker-compose
  helm
  kubectl
  kube-ps1
  minikube
  mvn
  gradle
  sudo
  rsync
  aws
  doctl
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

if [[ "$(command -v kubeoff)" ]]; then
  kubeoff
fi
PROMPT='$(kube_ps1)'$PROMPT
