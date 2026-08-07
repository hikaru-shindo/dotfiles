---@module 'hl'

-- AUTOSTART
hl.on("hyprland.start", function()
    -- Start daemons and background applications
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("swaync &")
    hl.exec_cmd("blueman-applet &")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("systemctl --user start hyprpolkitagent &")
    -- Start graphical applications
    hl.exec_cmd(PROGRAMMES.terminal, {
        workspace = 1,
    })
    hl.exec_cmd(PROGRAMMES.systemMonitor, {
        workspace = 1,
    })
    hl.exec_cmd(PROGRAMMES.terminal, {
        workspace = 1,
    })
    hl.exec_cmd(PROGRAMMES.browser, {
        workspace = 2,
    })
    -- clipboard management
    hl.exec_cmd("cliphist wipe") -- wipe clipboard history on every login
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- stores only image data
end)
