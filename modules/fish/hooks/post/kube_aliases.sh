#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

# Initialize kubectl_aliases
log info "Updating kubectl aliases"
exec curl --silent -o "${HOME}/.config/fish/conf.d/kubectl_aliases.fish" https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases.fish || log error "could not update kubectl aliases"
