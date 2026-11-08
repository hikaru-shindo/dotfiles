#!/usr/bin/env bash

MODULE_DIR=$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")
MODULE_NAME=$(basename "${MODULE_DIR}")
export MODULE_DIR MODULE_NAME

# Load common library functions
source "${MODULE_DIR}/../../lib/common.sh"

gtk_theme_exists() {
    local theme="${1:?usage: gtk_theme_exists THEME [GTK_VERSION]}"
    local version="${2:-3.0}"
    local -a dirs data_dirs
    local dir

    dirs=("${XDG_DATA_HOME:-${HOME}/.local/share}/themes" "${HOME}/.themes")
    IFS=: read -ra data_dirs <<< "${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
    for dir in "${data_dirs[@]}"; do
        dirs+=("${dir}/themes")
    done

    for dir in "${dirs[@]}"; do
        if [[ -f "${dir}/${theme}/gtk-${version}/gtk.css" ]]; then
            printf '%s\n' "${dir}/${theme}"
            return 0
        fi
    done

    return 1
}
