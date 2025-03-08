#!/usr/bin/env bash

set -euo pipefail

# settings
gtk_theme="catppuccin-mocha-blue-standard+default"

source=$(dirname "$(realpath "$0")")

# TODO: This needs heavy refactoring but works for testing :)

if [[ ! $(command -v stow) ]];
then
    echo >&2 "stow is not installed. Aborting."
    exit 1
fi

echo "Using source: ${source}"
echo "Using target: ${HOME}"

function install_dotfiles {
    local module=$1
    echo "-> Stowing module ${module}"
    stow --verbose --no-folding --dotfiles --target "${HOME}" -S "${module}"
}

function create_directory {
    local directory=$1
    if [[ ! -d "${directory}" ]];
    then
        echo "-> Creating directory ${directory}"
        mkdir -p "${directory}"
    else
        echo "-> ${directory} already exists. Skipping."
    fi
}

function link_gtk {
    local version=$1
    ln -sf "${HOME}/.local/share/themes/${gtk_theme}/gtk-${version}/gtk.css" "${HOME}/.config/gtk-${version}/gtk.css"
    ln -sf "${HOME}/.local/share/themes/${gtk_theme}/gtk-${version}/gtk-dark.css" "${HOME}/.config/gtk-${version}/gtk-dark.css"
    ln -sf "${HOME}/.local/share/themes/${gtk_theme}/gtk-${version}/assets" "${HOME}/.config/gtk-${version}/assets"
}

modules=(
    alacritty
    ghostty
    kitty
    wezterm
    fish
    k9s
    lazygit
    btop
    git
    nvim
    tmux
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
        sway
        swaync
        hypr
        mako
        waybar
        wofi
        rofi
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
    mv "${XDG_PICTURES_DIR}/screenshots/"* "${XDG_SCREENSHOT_DIR}"
    echo "-> Removing old screenshot dir ${XDG_PICTURES_DIR}/screenshots"
    rm -rf "${XDG_PICTURES_DIR}/screenshots"
fi

# TODO: init fisher

# Initialising tmux
echo "-> Setting up tmux plugin manager"
if [[ ! -d "${HOME}/.config/tmux/plugins/tpm" ]];
then
    echo "-> Ensuring tmux plugins directory"
    create_directory "${HOME}/.config/tmux/plugins"
    echo "-> Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm "${HOME}/.config/tmux/plugins/tpm"
else
    echo "-> Updating tmux plugin manager"
    git -C "${HOME}/.config/tmux/plugins/tpm" pull --rebase
fi

"${HOME}/.config/tmux/plugins/tpm/scripts/install_plugins.sh"

# Initialize neovim
if [[ $(command -v nvim) ]];
then
    echo "-> Updating neovim plugins"
    nvim --headless '+Lazy! sync' +qall || true
fi

# Initialize kubectl_aliases
echo "-> Updating kubectl aliases"
curl -o "${HOME}/.config/fish/conf.d/kubectl_aliases.fish" https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases.fish

if [[ $(uname) == "Linux" ]];
then
    echo "-> Configuring GTK themes"
    link_gtk "3.0"
    link_gtk "4.0"
fi

if [[ $(command -v xdg-user-dirs-gtk-update) ]];
then
    echo "-> Updating GTK bookmarks"
    xdg-user-dirs-gtk-update
fi

if [[ $(command -v flatpak) ]];
then
    echo "-> Configuring flatpak"
    flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    # This seems not to work properly at the moment but I'll keep it here for the
    # time being
    flatpak override --user --filesystem="xdg-config/gtk-3.0:ro"
    flatpak override --user --filesystem="xdg-config/gtk-4.0:ro"
    flatpak override --user --filesystem="xdg-data/themes:ro"
    flatpak override --user --filesystem="${source}/gtk:ro"
fi
