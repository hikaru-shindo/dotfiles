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

