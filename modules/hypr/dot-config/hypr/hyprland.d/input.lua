---@module 'hl'

-- INPUT

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
        numlock_by_default = true,
        follow_mouse = 0, -- disable "focus follows mouse"
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false,
        },
    },
})
