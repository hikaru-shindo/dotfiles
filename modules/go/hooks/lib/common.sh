#!/usr/bin/env bash

MODULE_DIR=$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")
MODULE_NAME=$(basename "${MODULE_DIR}")
export MODULE_DIR MODULE_NAME

# Load common library functions
source "${MODULE_DIR}/../../lib/common.sh"
