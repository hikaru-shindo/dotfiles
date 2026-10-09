#!/usr/bin/env bash

MODULE_DIR=$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")
MODULE_NAME=$(basename "${MODULE_DIR}")
export MODULE_DIR MODULE_NAME

# Load common library functions
source "${MODULE_DIR}/../../lib/common.sh"

function zen_installed {
    local candidate

    for candidate in zen-browser zen app.zen_browser.zen;
    do
        command -v "${candidate}" > /dev/null && return 0
    done

    if [[ $(uname) == "Darwin" ]];
    then
        for candidate in {/Applications,"${HOME}/Applications"}/{Zen,"Zen Browser"}.app;
        do
            [[ -d "${candidate}" ]] && return 0
        done
    fi

    return 1
}

function zen_config_directory {
    echo -n "${XDG_CONFIG_HOME:-${HOME}/.config}/zen"
}

# Prints every Zen profile directory under the Zen config directory, one per line.
# Profiles are taken from profiles.ini, plus any directory that looks like a
# profile (contains prefs.js or times.json).
function zen_profiles {
    local zen_dir
    local ini
    local key
    local value
    local path=''
    local is_relative=1
    local candidate
    local directory
    local -A seen=()

    zen_dir=$(realpath "$(zen_config_directory)")
    ini="${zen_dir}/profiles.ini"

    function _zen_emit_profile {
        candidate=$(realpath -m -- "$1")
        [[ -d "${candidate}" ]] || return 0
        [[ "${candidate}" == "${zen_dir}"/* ]] || return 0
        [[ -n "${seen[${candidate}]:-}" ]] && return 0
        seen[${candidate}]=1
        echo "${candidate}"
    }

    function _zen_flush_section {
        if [[ -n "${path}" ]];
        then
            if [[ "${is_relative}" == 1 ]];
            then
                _zen_emit_profile "${zen_dir}/${path}"
            else
                _zen_emit_profile "${path}"
            fi
        fi
        path=''
        is_relative=1
    }

    if [[ -f "${ini}" ]];
    then
        while IFS='=' read -r key value || [[ -n "${key}" ]];
        do
            key="${key%$'\r'}"
            value="${value%$'\r'}"
            case "${key}" in
                \[*\])
                    _zen_flush_section
                ;;
                Path)
                    path="${value}"
                ;;
                IsRelative)
                    is_relative="${value}"
                ;;
            esac
        done < "${ini}"
        _zen_flush_section
    fi

    for directory in "${zen_dir}"/*/;
    do
        if [[ -f "${directory}/prefs.js" || -f "${directory}/times.json" ]];
        then
            _zen_emit_profile "${directory}"
        fi
    done

    unset -f _zen_emit_profile _zen_flush_section
}

# Sets a preference in a profile's user.js, which Zen applies on every start.
# Usage: zen_user_pref PROFILE_DIR PREF_NAME VALUE
# VALUE is written verbatim, so quote strings yourself (e.g. '"foo"').
function zen_user_pref {
    local profile="$1"
    local name="$2"
    local value="$3"
    local user_js="${profile}/user.js"
    local line="user_pref(\"${name}\", ${value});"
    local pattern="\"${name//./\\.}\""

    if [[ -f "${user_js}" ]] && grep -q -- "${pattern}" "${user_js}";
    then
        if grep -Fqx -- "${line}" "${user_js}";
        then
            log debug "${name} already set in ${user_js}. skipping."
            return 0
        fi
        exec sed -i "/${pattern}/c\\${line}" "${user_js}"
        return 0
    fi

    # Make sure we append on a new line
    if [[ -s "${user_js}" && $(tail -c1 -- "${user_js}") != '' ]];
    then
        exec_silent tee -a "${user_js}" <<< ''
    fi
    exec_silent tee -a "${user_js}" <<< "${line}"
}

function link_userchrome {
    local profile="$1"
    local source_css="$2"
    local chrome="${profile}/chrome"
    local target="${chrome}/userChrome.css"
    local backup

    create_directory "${chrome}"

    if [[ -L "${target}" ]];
    then
        if [[ $(readlink -- "${target}") == "${source_css}" ]];
        then
            log debug "${target} already linked. skipping."
            return 0
        fi
        exec rm -- "${target}"
    elif [[ -e "${target}" ]];
    then
        backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
        log warn "Backing up existing ${target} to ${backup##*/}"
        exec mv -- "${target}" "${backup}"
    fi

    exec ln -s -- "${source_css}" "${target}"
}
