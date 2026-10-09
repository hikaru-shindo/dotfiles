#!/usr/bin/env bash

######################
# Path helper
######################

function source_directory {
    dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
}

function target_directory {
    echo -n "${HOME}"
}

function modules_directory {
    echo -n "$(source_directory)/modules"
}

function profiles_directory {
    echo -n "$(source_directory)/profiles"
}

function state_directory {
    echo -n "${XDG_STATE_HOME:-${HOME}/.local/state}/dotfiles"
}

######################
# Output
######################
function _log_level_numeric {
    local level="$1"

    case "${level}" in
        debug)
            echo 0
        ;;
        warn)
            echo 2
        ;;
        error)
            echo 3
        ;;
        *)
            # info, success and unknown levels
            echo 1
        ;;
    esac
}

function log {
    local level="$1"
    local message="${*:2}"

    local colour_reset='\033[0m'
    local colour
    local threshold

    threshold=$(_log_level_numeric "${LOG_LEVEL:-info}")
    if (( $(_log_level_numeric "${level}") < ${threshold} )); then
        return 0
    fi

    case "$level" in
        debug)
            colour='\033[90m' # dark grey
        ;;
        warn)
            colour='\033[33m' # orange/yellow
        ;;
        error)
            colour='\033[1;31m' # bold red
        ;;
        notice)
            colour='\033[36m' # cyan
        ;;
        success)
            colour='\033[32m' # bold green
        ;;
        *)
            colour='\033[0m'  # default foreground colour (default/info)
        ;;
    esac

    case "$level" in
        warn|error)
            echo -e "${colour}[${level}] ${message}${colour_reset}" >&2
        ;;
        *)
            echo -e "${colour}[${level}] ${message}${colour_reset}"
        ;;
    esac
}

######################
# Command execution
######################

function exec {
    log debug "${@}"
    command "${@}"
    return $?
}

function exec_silent {
    log debug "${@}"
    command "${@}" > /dev/null
    return $?
}

function exec_conditional {
    local command_name="$1"
    local callback="$2"
    shift 2

    if [[ ! $(command -v "${command_name}") ]]; then
        log warn "${command_name} not installed, skipping."
        return 0
    fi

    if ! declare -F "${callback}" > /dev/null; then
        log error "callback ${callback} is not a function"
        return 1
    fi

    "${callback}" "$@"
}

######################
# Filesystem
######################
function create_directory {
    local directory=$1
    if [[ ! -d "${directory}" ]];
    then
        exec mkdir -p "${directory}"
    else
        log debug "${directory} already exists. skipping."
    fi
}

######################
# Settings
######################
function gsettings_set {
    local group="$1"
    local key="$2"
    local value="${3:-}"

    if [[ -z "${group}" || -z "${key}" ]];
    then
        log error "invalid gsettings group or key group=${group} key=${key}"
        return 1
    fi

    if [[ ! -z "${value}" ]];
    then
        exec gsettings set "${group}" "${key}" "${value}"
    else
        exec gsettings reset "${group}" "${key}"
    fi
}

######################
# Platform
######################
function platform_tags {
    local tags=()
    local like
    local i

    case "$(uname -s)" in
        Linux)
            tags+=(linux)
            if [[ -r /etc/os-release ]]; then
                # ID_LIKE lists the closest relative first, so it is
                # reversed to keep the order generic to specific.
                read -r -a like <<< "$(source /etc/os-release && echo "${ID_LIKE:-}")"
                for (( i = ${#like[@]} - 1; i >= 0; i-- )); do
                    tags+=("${like[i]}")
                done
                tags+=("$(source /etc/os-release && echo "${ID:-}")")
            fi
        ;;
        Darwin)
            tags+=(darwin)
        ;;
    esac

    echo -n "${tags[*]}"
}

function platform_matches {
    local tag
    local platform_tag

    for platform_tag in $(platform_tags); do
        for tag in "$@"; do
            if [[ "${tag}" == "${platform_tag}" ]]; then
                return 0
            fi
        done
    done

    return 1
}

######################
# Desktop entries
######################
function desktop_entry_exists {
    local desktop_entry="$1"
    local data_directory
    local data_directories

    IFS=: read -r -a data_directories <<< "${XDG_DATA_HOME:-${HOME}/.local/share}:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
    for data_directory in "${data_directories[@]}"; do
        if [[ -f "${data_directory}/applications/${desktop_entry}" ]]; then
            return 0
        fi
    done

    return 1
}
