#!/usr/bin/env bash
# This script runs the hypridle.service systemd-unit inside a Hyprland session and
# cleans it up once the session ends, so that it does not pollute other graphical
# sessions when switching compositors without reboot.
set -u

compositor_vars=(WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE)

cleanup() {
    systemctl --user stop hypridle.service
    systemctl --user unset-environment "${compositor_vars[@]}"
}
trap cleanup EXIT
trap 'exit 0' TERM HUP INT

# hypridle, hyprctl and hyprlock need some variables to reach the compositor instance
systemctl --user import-environment "${compositor_vars[@]}"

# restart over start, so stale instances just get restarted
systemctl --user restart hypridle.service

# hyprctl fails as soon as its instance's socket is gone, including after a crash
# once this happens we can cleanup
while hyprctl version >/dev/null 2>&1; do
    sleep 5
done
