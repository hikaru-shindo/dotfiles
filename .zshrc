# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="pnitsche"

plugins=(
  ssh-agent 
  git
  docker
  docker-compose
  helm
  kubectl
  minikube
  sudo
)

source ${ZSH}/oh-my-zsh.sh

