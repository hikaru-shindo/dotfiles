#!/bin/bash
set -euo pipefail

# This script uses rofi and cliphist to selected and directly paste the
# selected entry instead of just putting it into the clipboard buffer, so
# you do not need to press CTRL+V afterwards.

list_command="${1:-rofi -dmenu -display-columns 2 -p Clipboard}"

selected_entry=$(cliphist list | ${list_command} | cliphist decode)

# Exit 0 if nothing is selected
[ -z "$selected_entry" ] && exit 0

echo -n "$selected_entry" | wl-copy

# Small delay to ensure the clipboard is populated before "pasting"
sleep 0.1

hyprctl dispatch sendshortcut "CTRL,V,"
