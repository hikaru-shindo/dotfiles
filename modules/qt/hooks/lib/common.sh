#!/usr/bin/env bash

MODULE_DIR=$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")
MODULE_NAME=$(basename "${MODULE_DIR}")
export MODULE_DIR MODULE_NAME

# Load common library functions
source "${MODULE_DIR}/../../lib/common.sh"

function qt_style_exists {
    local style_name="${1,,}" qtpaths dir
    local -a plugin_dirs=()

    # Ask Qt itself where its plugins are, if its path tool can be found
    for qtpaths in qtpaths6 qtpaths-qt6 /usr/lib/qt6/bin/qtpaths /usr/lib64/qt6/bin/qtpaths; do
        if command -v "${qtpaths}" >/dev/null; then
            plugin_dirs+=("$("${qtpaths}" --query QT_INSTALL_PLUGINS)")
            break
        fi
    done

    # Extra plugin paths from the environment, then the usual distro locations
    if [[ -n "${QT_PLUGIN_PATH:-}" ]]; then
        IFS=: read -ra dirs <<< "${QT_PLUGIN_PATH}"
        plugin_dirs+=("${dirs[@]}")
    fi
    plugin_dirs+=(
        /usr/lib/qt6/plugins
        /usr/lib64/qt6/plugins
        "/usr/lib/$(uname -m)-linux-gnu/qt6/plugins"
    )

    for dir in "${plugin_dirs[@]}"; do
        compgen -G "${dir}/styles/*${style_name}*.so" >/dev/null && return 0
    done

    return 1
}
