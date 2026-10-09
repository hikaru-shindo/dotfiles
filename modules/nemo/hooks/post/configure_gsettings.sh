#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_nemo {
    log info "Setting Nemo preferences"
    gsettings_set org.cinnamon.desktop.default-applications.terminal exec kitty # use kitty as default terminal
    gsettings_set org.nemo.preferences size-prefixes base-2 # use binary prefixes
    gsettings_set org.nemo.preferences date-format iso # use iso dates
    gsettings_set org.nemo.preferences show-location-entry true # show file path on top
    gsettings_set org.nemo.preferences show-advanced-permissions true # expert mode :)
    gsettings_set org.nemo.preferences sort-directories-first true # dis first :)
    gsettings_set org.nemo.preferences executable-text-activation launch # launch executable scripts by default
    gsettings_set org.nemo.preferences show-image-thumbnails always # always show thumbnails
    gsettings_set org.nemo.preferences thumbnail-limit 30 # max size for thumbnail creation in MiB
    # some toolbar stuff
    gsettings_set org.nemo.preferences show-computer-icon-toolbar false
    gsettings_set org.nemo.preferences show-home-icon-toolbar true
    gsettings_set org.nemo.preferences show-up-icon-toolbar true
    gsettings_set org.nemo.preferences show-reload-icon-toolbar false
}

exec_conditional gsettings "configure_nemo"
