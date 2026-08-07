---@module 'hl'

-- ENVIRONMENT VARIABLES

-- XDG Specification
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- kde plasma app fix ... annoyinga
hl.env("XDG_MENU_PREFIX", "arch-")

-- Cursors
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- Input methods

-- See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
-- hl.env("QT_IM_MODULE", "fcitx")
-- hl.env("XMODIFIERS", "@im=fcitx")
-- hl.env("GTK_IM_MODULE", "wayland") -- crashes electron apps in xwayland
-- hl.env("SDL_IM_MODULE", "fcitx")
-- hl.env("GLFW_IM_MODULE", "ibus")
-- hl.env("INPUT_METHOD", "fcitx")

-- Qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)

-- GTK
hl.env("GTK_USE_PORTAL", 1) -- force zen browser to use the desktop portal

-- Waylannd Backends
hl.env("MOZ_ENABLE_WAYLAND", 1)
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("GDK_BACKEND", "wayland")
