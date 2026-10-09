#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_celluloid {
    log info "Setting Celluloid preferences"

    # Disable CSDs - I don't use GNOME and this is more space efficient
    gsettings_set io.github.celluloid-player.Celluloid csd-enable false
}

exec_conditional gsettings "configure_celluloid"
