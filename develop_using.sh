#!/bin/bash

# This script is used to run current flask application using specified environment

set -euox  pipefail
IFS=$'\n\t'

declare -r SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
declare -r VIRTUAL_ENV_NAME=".venv_flask_opinionated"
declare -r PORT=12121

function static_analyse {
    echo 'Static analysis'
}

function use_venv {
    "${SCRIPT_DIR}"/tools/setup_virtualenv.sh

    unset PYTHONPATH
    export PYTHONPATH="."
    unset MYPYPATH
    export MYPYPATH="."

    echo "Sourcing python virtual environment ${SCRIPT_DIR}/${VIRTUAL_ENV_NAME}"
    set +x
    source "${SCRIPT_DIR}/${VIRTUAL_ENV_NAME}"/bin/activate
    set -x

    "${SCRIPT_DIR}"/tools/install_pip_requirements.sh
}

function run {
    trap static_analyse EXIT
    # run flask
}

function main {
    local env=${1?Environment (prod/preprod/local) is required}
    use_venv
    run "${env}"
}

main "$@"
