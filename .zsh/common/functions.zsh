LFILE="/etc/*-release"
MFILE="/System/Library/CoreServices/SystemVersion.plist"

function get_distro() {
    if [[ -f $LFILE ]]; then
        echo $(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
    elif [[ -f $MFILE ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

function get_os_family() {
    if [[ -f $LFILE ]]; then
        echo "linux"
    elif [[ -f $MFILE ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}
