#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function update_gtk_bookmarks {
    log info "Updating GTK bookmarks"
    exec xdg-user-dirs-gtk-update
}

exec_conditional xdg-user-dirs-gtk-update "update_gtk_bookmarks"
