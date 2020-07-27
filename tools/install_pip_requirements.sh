#!/bin/bash

set -euox pipefail
IFS=$'\n\t'

declare -r SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

function main() {
  pip install pip-tools
  pip-compile -q requirements.in
  pip-compile -q dev-requirements.in
  pip install -q -r requirements.txt -r dev-requirements.txt
}

(
  cd "${SCRIPT_DIR}"
  main
)
