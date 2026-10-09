#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function update_gnome_settings {
    log info "Setting GNOME settings"
    gsettings_set org.gnome.desktop.interface color-scheme prefer-dark
}

exec_conditional gsettings "update_gnome_settings"
