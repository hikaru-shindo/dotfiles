#!/usr/bin/env bash

set -e

targetDir=${HOME}
cd $(dirname ${0})
thisDir=$(pwd)

#echo "-> Update submodules"
#git submodule update --init --recursive

echo "-> Link my zsh themes"
mkdir -pv .oh-my-zsh/custom/themes
ln -svf ${thisDir}/zeta.zsh-theme ${targetDir}/.oh-my-zsh/custom/themes/
ln -svf ${thisDir}/pnitsche.zsh-theme ${targetDir}/.oh-my-zsh/custom/themes/

echo "-> Ensure config dir"
mkdir -p ${targetDir}/.config

echo "-> Ensure user binary dir"
mkdir -p ${targetDir}/bin

echo "-> Create symlinks in ${targetDir}"
for file in $(cat symlinks); do
    rm -rf ${targetDir}/${file}
    ln -svT ${thisDir}/${file} ${targetDir}/${file}
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

if [ "${SHELL}" != "/usr/bin/zsh" ]; then
    echo "-> Set zsh as default shell"
    chsh -s /usr/bin/zsh
fi
