#!/usr/bin/env bash

set -e

targetDir=${HOME}
cd $(dirname ${0})
thisDir=$(pwd)

echo "-> Ensure config directories"
mkdir -p ${targetDir}/.config
mkdir -p ${targetDir}/.zsh
mkdir -p ${targetDir}/.warp/themes
mkdir -p ${targetDir}/.warp/workflows

echo "-> Ensure user binary dir"
mkdir -p ${targetDir}/bin

echo "-> Fetching current kubectl aliases"
curl -O https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases

echo "-> Create symlinks in ${targetDir}"
for file in $(cat symlinks); do
    rm -rf ${targetDir}/${file}
    ln -sv ${thisDir}/${file} ${targetDir}/${file}
done

echo "-> Initializing vim"
vim +PlugInstall +qall

echo "-> Ensure user dirs exist"
source ${thisDir}/.config/user-dirs.dirs
mkdir -p ${XDG_DESKTOP_DIR}
mkdir -p ${XDG_DOCUMENTS_DIR}
mkdir -p ${XDG_DOWNLOAD_DIR}
mkdir -p ${XDG_MUSIC_DIR}
mkdir -p ${XDG_PICTURES_DIR}
mkdir -p ${XDG_VIDEOS_DIR}
mkdir -p ${XDG_PICTURES_DIR}/screenshots

echo "-> Setting up fish"
mkdir -p ${targetDir}/.config/fish
mkdir -p ${targetDir}/.config/fish/conf.d

rm -f ${targetDir}/.config/fish/config.fish
ln -sv ${thisDir}/.config/fish/config.fish ${targetDir}/.config/fish/config.fish
for file in $(find ${thisDir}/.config/fish/conf.d -type f -execdir echo {} ';'); do
    rm -f ${targetDir}/.config/fish/conf.d/${file}
    ln -sv ${thisDir}/.config/fish/conf.d/${file} ${targetDir}/.config/fish/conf.d/${file}
done

if [ "${SHELL}" != $(which zsh) ]; then
    echo "-> Set zsh as default shell"
    chsh -s $(which zsh)
fi
