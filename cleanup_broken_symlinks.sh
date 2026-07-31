#!/usr/bin/env bash

set -euo pipefail

source=$(dirname "$(realpath "$0")")
target="${HOME}"

if [[ ! -d "${target}" ]];
then
    echo >&2 "${target} is not a directory or does not exist"
    exit 2
fi

echo "=> Target directory: ${target}"
echo "=> Finding broken symlinks to dotfiles..."
broken_links=()
while IFS= read -r link; do
    link_target=$(readlink "${link}")

    # Resolve relative paths to absolute
    if [[ "${link_target}" != /* ]]; then
        # Relative path - resolve from link's directory
        resolved_link=$(cd "$(dirname "${link}")" && readlink -m "${link_target}")
    else
        # Absolute path
        resolved_link="${link_target}"
    fi

    # Check if resolved path points to dotfiles
    if [[ "${resolved_link}" == "${source}"* ]]; then
        broken_links+=("${link}")
    fi
done < <(find "${target}" -xdev -type l 2>/dev/null)

if [[ ${#broken_links[@]} -gt 0 ]]; then
    echo "The following broken symlinks will be removed:"
    printf '  %s\n' "${broken_links[@]}"
    echo
    read -p "Continue? [yN] " -n 1 continue
    echo
    if [[ ! $continue =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi

    echo "=> Removing broken symlinks..."
    for link in "${broken_links[@]}"; do
        rm -v "${link}"
    done
else
    echo "No broken symlinks found."
fi
