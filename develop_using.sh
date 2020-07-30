#!/bin/bash

# This script is used to run current flask application using specified environment

set -euox pipefail
IFS=$'\n\t'

declare -r SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare -r VIRTUAL_ENV_NAME=".venv"
declare -r PORT=12121

function format_fix_and_check() {
  make format
  make lint
}

function use_venv() {
  make venv

  echo "Sourcing python virtual environment ${SCRIPT_DIR}/${VIRTUAL_ENV_NAME}"
  set +x
  unset PYTHONPATH
  export PYTHONPATH="."
  unset MYPYPATH
  export MYPYPATH="."
  source "${SCRIPT_DIR}/${VIRTUAL_ENV_NAME}"/bin/activate
  set -x
}

function run() {
  trap format_fix_and_check EXIT
  FLASK_APP="${SCRIPT_DIR}"/service.py flask run --port $PORT
}

function main() {
  local env=${1:-local}
  use_venv
  run "${env}"
}

main "$@"
