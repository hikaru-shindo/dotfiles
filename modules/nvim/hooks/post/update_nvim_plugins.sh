#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function update_nvim_plugins {
    log info "Updating neovim plugins"
    exec_silent nvim --headless '+Lazy! sync' +qall || log error "nvim could not be initialised"
}

exec_conditional nvim "update_nvim_plugins"
