#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

declare -r SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare -r MAJOR=3
declare -r MINOR=7

function ensure_python_version() {
  local python_version_check
  python_version_check=$(python -c "import sys; print(sys.version_info[:][0]==${MAJOR} and sys.version_info[:][1]>=${MINOR})")
  if [[ "${python_version_check}" != True ]]; then
    echo "ERROR: Expected python version >= ${MAJOR}.${MINOR}"
    exit 1
  fi
}

function main() {
  ensure_python_version
  local venv_name=${1?Required virtualenv name}
  local venv_dir="${SCRIPT_DIR}/../${venv_name}"
  if [[ -d "${venv_dir}" ]]; then
    return
  fi
  python -m venv "${venv_dir}"
}

main "$@"
