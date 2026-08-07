---@module 'hl'

-- KEYBINDINGS
local mainMod = "SUPER"

-- general binds
hl.bind(mainMod .. " + SHIFT" .. " + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT" .. " + C", hl.dsp.exec_cmd("hyprctl reload config-only"))

-- general shortcuts
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(PROGRAMMES.terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(PROGRAMMES.menu))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(PROGRAMMES.calculator))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(PROGRAMMES.fileManager))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(PROGRAMMES.locker))

-- clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(PROGRAMMES.clipboardManager))

-- screenshots
hl.bind("Print", hl.dsp.exec_cmd(PROGRAMMES.screenshotArea))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(PROGRAMMES.screenshotWindow))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(PROGRAMMES.screenshotScreen))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(PROGRAMMES.screenshotArea))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(PROGRAMMES.screenshotWindow))
hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd(PROGRAMMES.screenshotScreen))

-- layout
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))

-- window management
hl.bind(mainMod .. " + SHIFT" .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT" .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT" .. " + space", hl.dsp.window.float())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- window positioning
hl.bind(mainMod .. " + SHIFT" .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT" .. " + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT" .. " + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT" .. " + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT" .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT" .. " + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT" .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT" .. " + right", hl.dsp.window.move({ direction = "right" }))

-- window focus management
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

-- move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- mouse:272 is left click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- mouse:273 is right click

-- resize with keyboard
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", "reset", function()
    hl.bind(" + H", hl.dsp.window.resize({ x = -10, y = 0 }))
    hl.bind(" + left", hl.dsp.window.resize({ x = -10, y = 0 }))
    hl.bind(" + J", hl.dsp.window.resize({ x = 0, y = 10 }))
    hl.bind(" + down", hl.dsp.window.resize({ x = 0, y = 10 }))
    hl.bind(" + K", hl.dsp.window.resize({ x = 0, y = -10 }))
    hl.bind(" + up", hl.dsp.window.resize({ x = 0, y = -10 }))
    hl.bind(" + L", hl.dsp.window.resize({ x = 10, y = 0 }))
    hl.bind(" + right", hl.dsp.window.resize({ x = 10, y = 0 }))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- window/workspace management
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + MINUS", hl.dsp.focus({ workspace = 11 }))
hl.bind(mainMod .. " + SHIFT + MINUS", hl.dsp.window.move({ workspace = 11 }))

hl.bind(mainMod .. " + EQUAL", hl.dsp.focus({ workspace = 12 }))
hl.bind(mainMod .. " + SHIFT + EQUAL", hl.dsp.window.move({ workspace = 12 }))

-- multimedia brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true })

-- multimedia audio control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
