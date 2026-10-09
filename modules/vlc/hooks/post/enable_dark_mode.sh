#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_vlc_network_metadata {
    if pgrep -x vlc > /dev/null;
    then
        log warn "VLC is running and may overwrite its configuration file on exit"
    fi

    log info "Enabling VLC dark mode"
    vlc_set qt qt-dark-palette 1
}

exec_conditional vlc "configure_vlc_network_metadata"
