#!/usr/bin/env fish

if command -sq nproc
    # Probably a Linux system
    set -xga MAKEFLAGS "-j$(nproc)"
else
    # Fallback to macOS
    set -xga MAKEFLAGS "-j$(math (sysctl -n hw.ncpu) - 1)"
end 

