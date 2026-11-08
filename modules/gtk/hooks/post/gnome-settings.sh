#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function update_gnome_settings {
    log info "Setting GNOME settings"
    gsettings_set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings_set org.gnome.desktop.interface gtk-theme adw-gtk3-dark

    if ! gtk_theme_exists adw-gtk3-dark >/dev/null; then
        log warn "GTK theme 'adw-gtk3-dark' missing. This may result in degraded ricing."
    fi
}

exec_conditional gsettings "update_gnome_settings"
