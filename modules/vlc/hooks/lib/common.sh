#!/usr/bin/env bash

MODULE_DIR=$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")
MODULE_NAME=$(basename "${MODULE_DIR}")
export MODULE_DIR MODULE_NAME

# Load common library functions
source "${MODULE_DIR}/../../lib/common.sh"

function vlc_set {
    local section="$1"
    local key="$2"
    local value="${3:-}"
    local config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/vlc"
    local rc_file="${config_dir}/vlcrc"

    if [[ -z "${section}" || -z "${key}" ]]; then
        log error "invalid vlc section or key section=${section} key=${key}"
        return 1
    fi

    if [[ ! -d "${config_dir}" ]]; then
        exec mkdir -p "${config_dir}"
    fi

    if [[ ! -f "${rc_file}" ]]; then
        exec touch "${rc_file}"
    fi

    if [[ -z "${value}" ]]; then
        if grep -qE "^${key}=" "${rc_file}";
        then
            exec sed -i -E "s|^${key}=|#${key}=|" "${rc_file}"
        else
            log debug "${key} already uses the default value. skipping."
        fi
    elif grep -qE "^#?${key}=" "${rc_file}"; then
        exec sed -i -E "s|^#?${key}=.*|${key}=${value}|" "${rc_file}"
    elif grep -qE "^\[${section}\]" "${rc_file}"; then
        exec sed -i -E "/^\[${section}\]/a ${key}=${value}" "${rc_file}"
    else
        exec_silent tee -a "${rc_file}" <<< $'\n'"[${section}]"$'\n'"${key}=${value}"
    fi
}
