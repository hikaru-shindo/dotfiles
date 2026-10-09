#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

function configure_zen_profiles {
    local zen_dir
    local source_css
    local profile
    local -a profiles

    zen_dir=$(zen_config_directory)
    source_css="${zen_dir}/userChrome.css"

    if [[ ! -d "${zen_dir}" ]];
    then
        log warn "No Zen configuration in ${zen_dir}. Start Zen once to create a profile, then rerun the installation."
        return 0
    fi

    if [[ ! -e "${source_css}" ]];
    then
        log error "${source_css} does not exist"
        return 1
    fi

    mapfile -t profiles < <(zen_profiles)

    if (( ${#profiles[@]} == 0 ));
    then
        log warn "No Zen profiles found in ${zen_dir}. Start Zen once to create a profile, then rerun the installation."
        return 0
    fi

    for profile in "${profiles[@]}";
    do
        log info "Configuring Zen profile ${profile##*/}"
        link_userchrome "${profile}" "${source_css}"
        zen_user_pref "${profile}" toolkit.legacyUserProfileCustomizations.stylesheets true
    done

    if pgrep -x 'zen|zen-bin' > /dev/null;
    then
        log warn "Zen is running. Restart it to apply the userChrome.css changes."
    fi
}

if ! zen_installed; then
    log warn "Zen not installed, skipping."
    exit 0
fi

configure_zen_profiles
