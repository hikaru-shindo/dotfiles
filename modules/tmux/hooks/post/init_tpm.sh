#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_tmux_plugin_manager {
    # Initialising tmux
    log info "Setting up tmux plugin manager"
    if [[ ! -d "${HOME}/.config/tmux/plugins/tpm" ]];
    then
        log info "Ensuring tmux plugins directory"
        create_directory "${HOME}/.config/tmux/plugins"
        log info "Installing tmux plugin manager"
        exec_silent git clone https://github.com/tmux-plugins/tpm "${HOME}/.config/tmux/plugins/tpm"
    else
        log info "Updating tmux plugin manager"
        exec_silent git -C "${HOME}/.config/tmux/plugins/tpm" pull --rebase
    fi

    exec_silent "${HOME}/.config/tmux/plugins/tpm/scripts/install_plugins.sh"
}

exec_conditional tmux "configure_tmux_plugin_manager"
