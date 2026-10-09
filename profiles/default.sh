# shellcheck shell=bash
#
# This profile is the default profile for any workstation with a graphical UI.
#
# This file is loaded by install.sh and is not meant to be run or
# sourced on its own. Select it with: ./install.sh default

if ! declare -F include_profile > /dev/null;
then
    echo "${BASH_SOURCE[0]}: profiles are loaded by install.sh and cannot be run independently" >&2
    return 1 2> /dev/null || exit 1
fi

include_profile cli

# Terminals
add_modules \
    alacritty \
    ghostty \
    kitty \
    wezterm

# Desktop Applications
add_modules \
    vlc \
    zen

if platform_matches linux; then
    # Desktop Environment
    add_modules \
        flatpak \
        gtk \
        nemo \
        qt \
        rofi \
        waybar \
        xdg

    # Compositors
    add_modules \
        hypr \
        niri
fi

if desktop_entry_exists nemo.desktop;
then
    set_default_application nemo.desktop inode/directory
fi

if desktop_entry_exists zen.desktop; then
    set_default_application zen.desktop \
        text/html \
        x-scheme-handler/about \
        x-scheme-handler/chrome \
        x-scheme-handler/http \
        x-scheme-handler/https \
        x-scheme-handler/unknown \
        application/x-extension-htm \
        application/x-extension-html \
        application/x-extension-shtml \
        application/x-extension-xhtml \
        application/x-extension-xht \
        application/xhtml+xml
fi

if desktop_entry_exists wine.desktop;
then
    set_default_application wine.desktop application/vnd.microsoft.portable-executable
fi

# Flatpak and Arch Linux - might break on other distros
if desktop_entry_exists org.mozilla.Thunderbird.desktop; then
    set_default_application org.mozilla.Thunderbird.desktop \
        text/calendar \
        message/rfc822 \
        x-scheme-handler/mailto \
        x-scheme-handler/mid \
        x-scheme-handler/webcal \
        x-scheme-handler/webcals \
        application/x-extension-ics
fi
