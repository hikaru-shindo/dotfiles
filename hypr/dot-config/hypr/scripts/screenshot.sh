#!/bin/bash
set -euo pipefail

mode=${1:-monitor}
save_dir=${2:-"~/Pictures"}
save_file="Screenshot-$(date +%F_%T).png"

window_command="hyprshot -m window"
output_command="hyprshot -m output"
region_command="hyprshot -m region"

if [[ $(command -v hyprcap) ]]; then
    window_command="hyprcap shot window"
    output_command="hyprcap shot monitor"
    region_command="hyprcap shot region"
fi

command=""
case "${mode}" in
    window)
        command="${window_command}"
        ;;
    region)
        command="${region_command}"
        ;;
    output)
        command="${output_command}"
        ;;
esac

if [[ -z "${command}" ]]; then
    exit 1
fi

${command} -z -f "${save_file}" -o "${save_dir}"

