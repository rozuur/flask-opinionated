#!/bin/bash

set -euox pipefail
IFS=$'\n\t'

declare -r SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare -r ROOT_DIR="${SCRIPT_DIR}/.."

function static_analyse() {
  local app="${ROOT_DIR}"/app
  isort "${app}"
  black "${app}" -l 119
  autoflake --remove-all-unused-imports --remove-unused-variables --remove-duplicate-keys -i -r "${app}"
  bandit -ll -iii -r "${app}"
  flake8 --statistics "${app}"
}

function main() {
  static_analyse
}

main
