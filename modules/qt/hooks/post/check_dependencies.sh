#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

style="Breeze"

if ! qt_style_exists "${style}"; then
    log warn "qt style '${style}' missing. Native qt apps will use the default style."
fi
if ! command -v qt6ct >/dev/null; then
    log warn "qt6ct missing. Native Qt apps will ignore the generated colours."
fi
if command -v qtpaths-qt5 >/dev/null || [[ "$(qtpaths --qt-version 2>/dev/null || true)" == 5.* ]]; then
    log warn "qt5 is installed: Qt 5 apps need 'qt5ct' and 'breeze5' for the same look."
fi

