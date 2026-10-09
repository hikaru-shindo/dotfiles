#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "$0")")/lib/common.sh"

if [[ ! $(command -v stow) ]]; then
    log error "stow is not installed."
    exit 2
fi

######################
# Stow Modules
######################
function install_dotfiles {
    local module=$1
    exec stow --verbose --no-folding --dotfiles \
        --ignore='^hooks' \
        --ignore='^README\.md' \
        --target "$(target_directory)" --dir "$(modules_directory)" -S "${module}"
}

function run_hooks {
    local module="$1"
    local stage="$2"
    local hook_directory="$(modules_directory)/${module}/hooks/${stage}"
    local hook

    if [[ ! -d "${hook_directory}" ]];
    then
        return 0
    fi

    for hook in "${hook_directory}"/*.sh;
    do
        [[ -f "${hook}" ]] || continue
        log info "Running ${stage} hook ${module}/${hook##*/}"
        if ! bash "${hook}";
        then
            log error "${stage} hook ${module}/${hook##*/} failed"
            return 1
        fi
    done
}

function install_module {
    local module="$1"

    if [[ ! -d "$(modules_directory)/${module}" ]];
    then
        log error "module ${module} does not exist"
        return 1
    fi

    if ! run_hooks "${module}" pre;
    then
        log error "pre hooks failed for ${module}. Skipping module."
        return 1
    fi

    if ! install_dotfiles "${module}";
    then
        log error "stow failed for ${module}. Skipping post hooks."
        return 1
    fi

    run_hooks "${module}" post
}

######################
# Profiles
######################
modules=()
declare -A default_applications=()
declare -A _loaded_profiles=()

function include_profile {
    local profile="$1"
    local profile_file

    profile_file="$(profiles_directory)/${profile}.sh"

    if [[ -n "${_loaded_profiles[${profile}]:-}" ]];
    then
        return 0
    fi
    _loaded_profiles["${profile}"]=1

    if [[ ! -f "${profile_file}" ]];
    then
        log error "profile ${profile} does not exist"
        return 1
    fi

    log debug "Loading profile ${profile}"
    source "${profile_file}"
}

function add_modules {
    local module
    local existing

    for module in "$@";
    do
        for existing in "${modules[@]}";
        do
            if [[ "${existing}" == "${module}" ]];
            then
                continue 2
            fi
        done
        modules+=("${module}")
    done
}

function set_default_application {
    local desktop_entry="$1"
    local mime_type
    shift

    for mime_type in "$@";
    do
        default_applications["${mime_type}"]="${desktop_entry}"
    done
}

function list_profiles {
    local profile

    for profile in "$(profiles_directory)"/*.sh;
    do
        [[ -f "${profile}" ]] || continue
        profile="${profile##*/}"
        echo -n "${profile%.sh} "
    done
}

######################
# Arguments
######################

requested_profiles=()
while (( $# ));
do
    case "$1" in
        -v|--verbose)
            LOG_LEVEL=debug
        ;;
        -q|--quiet)
            LOG_LEVEL=warn
        ;;
        -*)
            log error "unknown option $1"
            exit 2
        ;;
        *)
            requested_profiles+=("$1")
        ;;
    esac
    shift
done
export LOG_LEVEL="${LOG_LEVEL:-info}"

profiles_state_file="$(state_directory)/profiles"

if (( ! ${#requested_profiles[@]} )) && [[ -f "${profiles_state_file}" ]];
then
    mapfile -t requested_profiles < "${profiles_state_file}"
    log info "Using previously selected profiles: ${requested_profiles[*]}"
fi

if (( ! ${#requested_profiles[@]} ));
then
    log error "No profile selected. Available profiles: $(list_profiles)"
    exit 2
fi

######################
# Installation
######################
log debug "Using source: $(source_directory)"
log debug "Using target: $(target_directory)"
log debug "Platform: $(platform_tags)"

for profile in "${requested_profiles[@]}";
do
    include_profile "${profile}" || exit 2
done

create_directory "$(state_directory)"
exec_silent tee "${profiles_state_file}" <<< "$(printf '%s\n' "${requested_profiles[@]}")"

log notice "Profiles: ${requested_profiles[*]}"
log notice "Modules: ${modules[*]}"

failed_modules=()
for module in "${modules[@]}"
do
    log notice "Installing module ${module}"
    install_module "${module}" || failed_modules+=("${module}")
done

if [[ $(command -v xdg-mime) ]];
then
    log notice "Setting default applications"
    for mime_type in "${!default_applications[@]}"; do
        if [[ $(command -v gio) ]]; then
            # use gio as this also adds the Added Association entry for convinience
            exec_silent gio mime "${mime_type}" "${default_applications[${mime_type}]}"
        else
            exec xdg-mime default "${default_applications[${mime_type}]}" "${mime_type}"
        fi
    done
fi

if (( ${#failed_modules[@]} )); then
    log error "The following modules could not be installed successfully: ${failed_modules[*]}"
    exit 1
fi

log success "Local user profile successfully configured"

