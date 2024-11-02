#!/usr/bin/env bash

set -euo pipefail

target=${1:-}
if [[ -z "${target}" ]];
then
    echo >&2 "Usage: cleanup_broken_links <target_directory>"
    exit 1
fi

if [[ ! -d "${target}" ]];
then
    echo >&2 "${target} is not a directory or does not exist"
    exit 2
fi

echo "The following links are broken: "
echo

find "${target}" -type l ! -exec [ -e {} ] \; -print 2> /dev/null || true

echo
read -p "Ask for confirmation? [Yn] " confirmation

if [[ "${confirmation,,}" = "n" ]];
then
    echo "-> Deleting without confirmation"
    find "${target}" -type l -type l ! -exec [ -e {} ] \; -exec rm {} \;
else
    echo "-> Deleting with confirmation"
    find "${target}" -type l ! -exec [ -e {} ] \; -exec rm -i {} \;
fi

echo
echo "-> Done"
