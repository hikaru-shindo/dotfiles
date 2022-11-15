if [ -x "$(command -v nproc)" ]; then # Linux
    export MAKEFLAGS="-j$(nproc)"
elif [ -x "$(command -v sysctl)" ]; then # macOS
    export MAKEFLAGS="$MAKEFLAGS -j$(($(sysctl -n hw.ncpu)-1))"
fi
