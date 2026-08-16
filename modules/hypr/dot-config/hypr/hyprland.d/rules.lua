---@module 'hl'

--WINDOWS AND WORKSPACES

-- nm-connection-editor
hl.window_rule({
    float = true,
    center = true,
    size = "(monitor_w*0.45) (monitor_h*0.45)",

    match = {
        class = "^(nm-connection-editor)$",
    },
})

-- xdg-desktop-portal-gtk
hl.window_rule({
    float = true,
    center = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)",

    match = {
        class = "(xdg-desktop-portal-gtk)",
    },
})

-- pavucontrol
hl.window_rule({
    float = true,
    center = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)",

    match = {
        class = "(org.pulseaudio.pavucontrol)",
    },
})

-- blueman-manager
hl.window_rule({
    float = true,
    center = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)",

    match = {
        class = "(blueman-manager)",
    },
})

-- mpv
hl.window_rule({
    opaque = true,
    idle_inhibit = "always",

    match = {
        class = "(mpv)",
    },
})

-- vlc
hl.window_rule({
    opaque = true,
    idle_inhibit = "always",

    match = {
        class = "(vlc)",
    },
})

-- steam
hl.window_rule({
    opaque = true,

    match = {
        class = "(steam)",
    },
})

-- zen-browser
hl.window_rule({
    workspace = 2,

    match = {
        class = "zen",
    },
})

-- firefox
hl.window_rule({
    workspace = 2,

    match = {
        class = "firefox",
    },
})

hl.window_rule({
    workspace = 2,

    match = {
        class = "firefox-developer-edition",
    },
})

-- nemo
hl.window_rule({
    float = true,
    center = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)",

    match = {
        class = "nemo",
        title = ".* Properties$",
    },
})

-- Dialog windows – float+center these windows.

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(Open File)(.*)$",
    },
})

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(Select a File)(.*)$",
    },
})

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(Choose wallpaper)(.*)$",
    },
})

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(Open Folder)(.*)$",
    },
})

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(Save As)(.*)$",
    },
})

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(Library)(.*)$",
    },
})

hl.window_rule({
    float = true,
    center = true,

    match = {
        title = "^(File Upload)(.*)$",
    },
})

-- Status windows
hl.window_rule({
    float = true,
    center = true,

    match = {
        class = "org.gnome.FileRoller",
        title = "Extract",
    }
})

-- Tearing
hl.window_rule({
    immediate = true,

    match = {
        title = [[.*\.exe]],
    },
})

hl.window_rule({
    immediate = true,

    match = {
        class = "^(steam_app)",
    },
})

-- disable blur for XWayland windows (or context menus with shadow would look weird)
hl.window_rule({
    no_blur = true,

    match = {
        xwayland = true,
    },
})

-- ignore maximize requests from apps

hl.window_rule({
    suppress_event = "maximize",

    match = {
        class = ".*",
    },
})

-- fix some dragging issues with XWayland
hl.window_rule({
    no_focus = true,

    match = {
        class = "^$",
        title = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0,
    },
})
