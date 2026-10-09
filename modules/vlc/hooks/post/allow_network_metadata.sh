#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_vlc_network_metadata {
    if pgrep -x vlc > /dev/null;
    then
        log warn "VLC is running and may overwrite its configuration file on exit"
    fi

    log info "Enabling VLC metadata for network files"
    vlc_set core metadata-network-access 1
    vlc_set qt qt-privacy-ask 0
}

exec_conditional vlc "configure_vlc_network_metadata"
