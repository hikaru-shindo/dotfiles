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

# Load custom config
source ${HOME}/.zsh/common/functions.zsh
source ${HOME}/.zsh/common/aliases.zsh
source ${HOME}/.zsh/common/make.zsh
source ${HOME}/.zsh/common/karn.zsh

case $(get_os_family) in
    linux)
        source ${HOME}/.zsh/linux/session.zsh
        source ${HOME}/.zsh/linux/termial.zsh
        ;;
    macos)
        source ${HOME}/.zsh/macos/homebrew.zsh
        ;;
esac

# Load local overrides
if [[ -f ${HOME}/.zsh/zlocal.zsh ]]; then
  source ${HOME}/.zsh/zlocal.zsh
fi

#Star Ship
eval "$(starship init zsh)"
