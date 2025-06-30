#!/bin/bash

set -euo pipefail

list_command="${1:-rofi -dmenu -display-columns 2 -p Clipboard}"

selected_entry=$(cliphist list | ${list_command} | cliphist decode)

if [ -n "$selected_entry" ]; then
    echo -n "$selected_entry" | wl-copy

    # Small delay to ensure the clipboard is updated before "pasting"
    sleep 0.1

    # Simulate Ctrl+V to paste the content into the active window
    # Just running wl-paste is unfortunately not enough
    wtype -M ctrl v
fi
