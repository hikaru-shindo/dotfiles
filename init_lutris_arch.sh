#!/usr/bin/env bash

set -euo pipefail

aur_helper=""
if [[ $(command -v paru) ]]; then
    aur_helper=paru
elif [[ $(command -v yay) ]]; then
    aur_helper=yay
fi

if [[ -z "$aur_helper" ]]; then
    echo "Please install yay or paru to install AUR packages."
    exit 1
fi

id_helper=""
if [[ $(command -v doas) ]]; then
    id_helper=doas
elif [[ $(command -v sudo) ]]; then
    id_helper=sudo
fi

if [[ -z "$id_helper" ]]; then
    echo "Please install and configure doas or sudo to install packages."
    exit 1
fi


echo "Using ${id_helper} for privileged command execution"
echo "Using ${aur_helper} for AUR packages"

echo "-> Updating package lists"
$id_helper pacman -Sy
$id_helper $aur_helper -Sy

echo "-> Installing wine"
$id_helper pacman -S wine-staging winetricks
$id_helper pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox
$aur_helper -S lib32-gst-plugins-base-libs

echo "-> Installing Steam Runtime"
$id_helper pacman -S steam

echo "-> Installing protonup-qt"
$aur_helper -S protonup-qt

echo "-> Installing lutris"
$id_helper pacman -S lutris

echo
echo "Done. Make sure Proton-GE and vlkd3d-proton are available to lutris with protonup-qt!"
