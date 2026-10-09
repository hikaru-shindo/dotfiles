# shellcheck shell=bash
#
# This profile is meant to be used on systems without a graphical UI (e.g. servers).
#
# This file is loaded by install.sh and is not meant to be run or
# sourced on its own. Select it with: ./install.sh cli

if ! declare -F include_profile > /dev/null;
then
    echo "${BASH_SOURCE[0]}: profiles are loaded by install.sh and cannot be run independently" >&2
    return 1 2> /dev/null || exit 1
fi

add_modules \
    btop \
    fish \
    git \
    k9s \
    kubeswitch \
    lazygit \
    nvim \
    podman \
    ssh \
    tmux \
    zellij

if platform_matches darwin; then
    add_modules \
        fish_darwin
fi

if platform_matches arch; then
    add_modules \
        pacman \
        paru
fi
