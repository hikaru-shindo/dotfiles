---@module 'hl'

-- COLOURS

COLOURS = require("themes.mocha")

-- MONITOR FALLBACK

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- PROGRAMMES

PROGRAMMES = {
    terminal = "kitty",
    systemMonitor = "kitty btop",
    browser = "zen-browser",
    fileManager = "nemo -n " .. os.getenv("HOME"),
    menu = "rofi -show drun -terminal kitty -modi run,drun,calc -no-drun-show-actions -scroll-method 0",
    calculator = "rofi -show calc -modi calc -no-show-match -no-sort",
    locker = "hyprlock",
    screenshotArea = "~/.config/hypr/scripts/screenshot.sh region ~/Screenshots",
    screenshotScreen = "~/.config/hypr/scripts/screenshot.sh output ~/Screenshots",
    screenshotWindow = "~/.config/hypr/scripts/screenshot.sh window ~/Screenshots",
    clipboardManager = "~/.config/hypr/scripts/clipboard-select.sh",
}

-- DYNAMIC CONFIGURATION

require(os.getenv("HOME") .. "/.config/hypr/hyprland.d/*")
