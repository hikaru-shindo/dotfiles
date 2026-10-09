#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_flatpak {
    log info "Configuring flatpak"
    exec flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    log info "Configuring flatpak GTK themes"
    exec flatpak override --user --filesystem="xdg-config/gtk-3.0:ro"
    exec flatpak override --user --filesystem="xdg-config/gtk-4.0:ro"
    exec flatpak override --user --filesystem="xdg-data/themes:ro"
    exec flatpak override --user --filesystem="$(modules_directory)/gtk:ro"

    # Needs org.kde.KStyle.Kvantum installed but still does not work
    # needs more investigation ...
    log info "Configuring flatpak Qt themes"
    exec flatpak override --user --filesystem="xdg-config/Kvantum:ro"
    exec flatpak override --user --filesystem="$(modules_directory)/qt:ro"
    exec flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
}

exec_conditional flatpak "configure_flatpak"
