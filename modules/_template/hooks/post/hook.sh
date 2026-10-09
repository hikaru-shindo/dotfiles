#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../lib/common.sh"

log warn "Edit ${BASH_SOURCE[0]} with actual post hook code or remove this file."
