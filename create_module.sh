#!/usr/bin/env bash

set -euo pipefail

source=$(dirname "$(realpath "$0")")

source "${source}/lib/common.sh"

target_module="${1:-}"
template_path="${source}/modules/_template"
target_module_path="${source}/modules/${target_module}"

if [[ -z "${target_module}" ]]; then
    log error "No name provided for new module"
    exit 1
fi

if [[ -e "${target_module_path}" ]]; then
    log error "${target_module} already exists in ${target_module_path}"
    exit 2
fi

if [[ ! -d "${template_path}" ]]; then
    log error "Template missing in ${template_path}"
    exit 3
fi

log info "Creating module ${target_module} in ${target_module_path}"
cp -a "${template_path}" "${target_module_path}"

log info "Module successfully created."
