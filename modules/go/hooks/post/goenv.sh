#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

command -v go >/dev/null || exit 0

create_directory "${HOME}/.local/share/go"
create_directory "${HOME}/.local/bin"
go env -w GOPATH="${HOME}/.local/share/go" GOBIN="${HOME}/.local/bin"
