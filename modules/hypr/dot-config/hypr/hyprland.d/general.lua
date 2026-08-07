---@module 'hl'

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = COLOURS.lavender,
            inactive_border = COLOURS.overlay0,
        },
    },

    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 2,
        disable_hyprland_logo = false,
    },
})
