#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

log info "Creating configuration directories"
source "${MODULE_DIR}/dot-config/user-dirs.dirs"
create_directory "${XDG_DESKTOP_DIR}"
create_directory "${XDG_DOCUMENTS_DIR}"
create_directory "${XDG_DOWNLOAD_DIR}"
create_directory "${XDG_MUSIC_DIR}"
create_directory "${XDG_PICTURES_DIR}"
create_directory "${XDG_PROJECTS_DIR}"
create_directory "${XDG_SCREENSHOT_DIR}"
create_directory "${XDG_VIDEOS_DIR}"
create_directory "${XDG_TEMPLATES_DIR}"
create_directory "${XDG_PUBLICSHARE_DIR}"
