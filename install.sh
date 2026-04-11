#!/usr/bin/env bash

set -euo pipefail

source=$(dirname "$(realpath "$0")")

# TODO: This needs heavy refactoring but works for testing :)

if [[ ! $(command -v stow) ]];
then
    echo >&2 "stow is not installed. Aborting."
    exit 1
fi

echo "Using source: ${source}"
echo "Using target: ${HOME}"

function exec {
    echo "[info] ${@}"
    command "${@}"
}

function install_dotfiles {
    local module=$1
    echo "-> Stowing module ${module}"
    exec stow --verbose --no-folding --dotfiles --target "${HOME}" -S "${module}"
}

function create_directory {
    local directory=$1
    if [[ ! -d "${directory}" ]];
    then
        echo "-> Creating directory ${directory}"
        exec mkdir -p "${directory}"
    else
        echo "-> ${directory} already exists. Skipping."
    fi
}

function gsettings_set {
    local group="$1"
    local key="$2"
    local value="${3:-}"

    if [[ -z "${group}" || -z "${key}" ]];
    then
        echo "[err] invalid gsettings group or key group=${group} key=${key}"
        return 1
    fi

    if [[ ! -z "${value}" ]];
    then
        exec gsettings set "${group}" "${key}" "${value}"
    else
        exec gsettings reset "${group}" "${key}"
    fi
}

modules=(
    alacritty
    ghostty
    kitty
    wezterm
    fish
    k9s
    kubeswitch
    lazygit
    btop
    git
    nvim
    tmux
    zellij
    podman
)

if [[ $(uname) == "Darwin" ]];
then
    modules+=(
        warp
        fish_darwin
    )
fi

if [[ $(uname) == "Linux" ]];
then
    modules+=(
        xdg
        gtk
        qt
        swaync
        waybar
        rofi
        # Compositors
        hypr
        niri
    )

    # Define Mime defaults
    #
    # As a lot of applications just overide the mimeapps.list
    # file and ignore the symlink, this solution does not
    # assume ownership of this file for the dotfiles repo.
    #
    # This however needs to be refactored - this approach in
    # this script is not really scalable.
    declare -A mime_types

    # Default browser
    mime_types["inode/directory"]="org.gnome.Nautilus.desktop"
    mime_types["text/html"]="zen.desktop"
    mime_types["x-scheme-handler/http"]="zen.desktop"
    mime_types["x-scheme-handler/https"]="zen.desktop"
    mime_types["x-scheme-handler/chrome"]="zen.desktop"
    mime_types["application/x-extension-htm"]="zen.desktop"
    mime_types["application/x-extension-html"]="zen.desktop"
    mime_types["application/x-extension-shtml"]="zen.desktop"
    mime_types["application/x-extension-xhtml"]="zen.desktop"
    mime_types["application/x-extension-xht"]="zen.desktop"
    mime_types["application/xhtml+xml"]="zen.desktop"

    # Windows executable
    mime_types["application/vnd.microsoft.portable-executable"]="wine.desktop"
fi

if [[ $(command -v lsb_release) && $(lsb_release -is) == "Arch" ]];
then
    modules+=(
        pacman
    )
fi

for module in "${modules[@]}"
do
    install_dotfiles "${module}"
done

# Setting up XDG_CONFIG_DIRS

echo "-> Creating configuration directories"
source "${source}/xdg/dot-config/user-dirs.dirs"
create_directory "${XDG_DESKTOP_DIR}"
create_directory "${XDG_DOCUMENTS_DIR}"
create_directory "${XDG_DOWNLOAD_DIR}"
create_directory "${XDG_MUSIC_DIR}"
create_directory "${XDG_PICTURES_DIR}"
create_directory "${XDG_SCREENSHOT_DIR}"
create_directory "${XDG_VIDEOS_DIR}"
create_directory "${XDG_TEMPLATES_DIR}"
create_directory "${XDG_PUBLICSHARE_DIR}"

# Migrate old screenshots
if [[ -d "${XDG_PICTURES_DIR}/screenshots" ]];
then
    echo "-> Migrating screenshots to new home ${XDG_SCREENSHOT_DIR}"
    exec mv "${XDG_PICTURES_DIR}/screenshots/"* "${XDG_SCREENSHOT_DIR}"
    echo "-> Removing old screenshot dir ${XDG_PICTURES_DIR}/screenshots"
    exec rm -rf "${XDG_PICTURES_DIR}/screenshots"
fi

# TODO: init fisher

if [[ $(command -v tmux) ]];
then
    # Initialising tmux
    echo "-> Setting up tmux plugin manager"
    if [[ ! -d "${HOME}/.config/tmux/plugins/tpm" ]];
    then
        echo "-> Ensuring tmux plugins directory"
        exec create_directory "${HOME}/.config/tmux/plugins"
        echo "-> Installing tmux plugin manager"
        exec git clone https://github.com/tmux-plugins/tpm "${HOME}/.config/tmux/plugins/tpm"
    else
        echo "-> Updating tmux plugin manager"
        exec git -C "${HOME}/.config/tmux/plugins/tpm" pull --rebase
    fi

    "${HOME}/.config/tmux/plugins/tpm/scripts/install_plugins.sh"
else
    echo "-> No tmux installed, skipping tmux plugin manager setup"
fi


# Initialize neovim
if [[ $(command -v nvim) ]];
then
    echo "-> Updating neovim plugins"
    exec nvim --headless '+Lazy! sync' +qall || true
fi

# Initialize kubectl_aliases
echo "-> Updating kubectl aliases"
exec curl -o "${HOME}/.config/fish/conf.d/kubectl_aliases.fish" https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases.fish

if [[ $(uname) == "Linux" ]];
then
    echo "-> Cofiguring dconf"
    if [[ $(command -v gsettings) ]];
    then
        echo "--> Setting GNOME settings"
        gsettings_set org.gnome.desktop.interface color-scheme prefer-dark
        echo "--> Setting Nemo preferences"
        gsettings_set org.cinnamon.desktop.default-applications.terminal exec kitty # use kitty as default terminal
        gsettings_set org.nemo.preferences size-prefixes base-2 # use binary prefixes
        gsettings_set org.nemo.preferences date-format iso # use iso dates
        gsettings_set org.nemo.preferences show-location-entry true # show file path on top
        gsettings_set org.nemo.preferences show-advanced-permissions true # expert mode :)
        gsettings_set org.nemo.preferences sort-directories-first true # dis first :)
        gsettings_set org.nemo.preferences executable-text-activation launch # launch executable scripts by default
        gsettings_set org.nemo.preferences show-image-thumbnails always # always show thumbnails
        gsettings_set org.nemo.preferences thumbnail-limit 30 # max size for thumbnail creation in MiB
        # some toolbar stuff
        gsettings_set org.nemo.preferences show-computer-icon-toolbar false
        gsettings_set org.nemo.preferences show-home-icon-toolbar true
        gsettings_set org.nemo.preferences show-up-icon-toolbar true
        gsettings_set org.nemo.preferences show-reload-icon-toolbar false
    else
        echo "--> [warn] gsettings not installed, skipping"
    fi
fi

if [[ $(command -v xdg-user-dirs-gtk-update) ]];
then
    echo "-> Updating GTK bookmarks"
    exec xdg-user-dirs-gtk-update
fi

if [[ $(command -v flatpak) ]];
then
    echo "-> Configuring flatpak"
    exec flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    echo "--> Configuring GTK themes"
    exec flatpak override --user --filesystem="xdg-config/gtk-3.0:ro"
    exec flatpak override --user --filesystem="xdg-config/gtk-4.0:ro"
    exec flatpak override --user --filesystem="xdg-data/themes:ro"
    exec flatpak override --user --filesystem="${source}/gtk:ro"

    # Needs org.kde.KStyle.Kvantum installed but still does not work
    # needs more investigation ...
    echo "--> Configuring Qt themes"
    exec flatpak override --user --filesystem="xdg-config/Kvantum:ro"
    exec flatpak override --user --filesystem="${source}/qt:ro"
    exec flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
fi

if [[ $(command -v xdg-mime) ]];
then
    echo "-> Setting XDG default applications"
    for mime in "${!mime_types[@]}"; do
        exec xdg-mime default "${mime_types[${mime}]}" "${mime}"
    done
fi
