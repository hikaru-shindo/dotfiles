#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

source "${MODULE_DIR}/dot-config/user-dirs.dirs"
if [[ -d "${XDG_PICTURES_DIR}/screenshots" ]];
then
    log info "Migrating screenshots to new home ${XDG_SCREENSHOT_DIR}"
    exec mv "${XDG_PICTURES_DIR}/screenshots/"* "${XDG_SCREENSHOT_DIR}"
    log info "Removing old screenshot dir ${XDG_PICTURES_DIR}/screenshots"
    exec rm -rf "${XDG_PICTURES_DIR}/screenshots"
fi
