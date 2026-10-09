#!/usr/bin/env bash

######################
# Output
######################
function log {
    local level=$1
    local message="${*:2}"

    local colour_reset='\033[0m'
    local colour

    case "$level" in
        debug)
            colour='\033[90m'
        ;;
        warn)
            colour='\033[33m'  # orange/yellow
        ;;
        error)
            colour='\033[31m'  # red
        ;;
        *)
            colour='\033[36m'  # light grey (default/info)
        ;;
    esac

    echo -e "${colour}[${level}] ${message}${colour_reset}"
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

function vlc_set {
    local section="$1"
    local key="$2"
    local value="${3:-}"
    local config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/vlc"
    local rc_file="${config_dir}/vlcrc"

    if [[ -z "${section}" || -z "${key}" ]];
    then
        log error "invalid vlc section or key section=${section} key=${key}"
        return 1
    fi

    if [[ ! -d "${config_dir}" ]]; then
        exec mkdir -p "${config_dir}"
    fi

    if [[ ! -f "${rc_file}" ]];
    then
        exec touch "${rc_file}"
    fi

    if [[ -z "${value}" ]];
    then
        if grep -qe "^${key}=" "${rc_file}";
        then
            exec sed -i -e "s|^${key}=|#${key}=|" "${rc_file}"
        else
            log debug "${key} already uses the default value. skipping."
        fi
    elif grep -qe "^#?${key}=" "${rc_file}";
    then
        exec sed -i -e "s|^#?${key}=.*|${key}=${value}|" "${rc_file}"
    elif exec grep -qe "^\[${section}\]" "${rc_file}";
    then
        exec sed -i -e "/^\[${section}\]/a ${key}=${value}" "${rc_file}"
    else
        exec_silent tee -a "${rc_file}" <<< $'\n'"[${section}]"$'\n'"${key}=${value}"
    fi
}
