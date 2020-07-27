#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

declare -r SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare -r VIRTUAL_ENV_NAME=".venv_flask_opinionated"

function ensure_python_version() {
  local python_version_check
  python_version_check=$(python -c 'import sys; print(sys.version_info[:][0]==3 and sys.version_info[:][1]>=7)')
  if [[ "${python_version_check}" != True ]]; then
    echo "ERROR: Expected python version >= 3.7"
    exit 1
  fi
}

function main {
  ensure_python_version
  local venv_dir="${SCRIPT_DIR}/../${VIRTUAL_ENV_NAME}"
  if [[ -d "${venv_dir}" ]]; then
      return
  fi
  python -m venv "${venv_dir}"
}

main
