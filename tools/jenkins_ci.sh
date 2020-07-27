#!/bin/bash

set -euox pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly SCRIPT_DIR

readonly GIT_BRANCH="${GIT_BRANCH:-__invalid__}"
readonly RELEASE="${RELEASE:-false}"
readonly USER="${USER}"
readonly APP_NAME="flask-opinionated"
readonly VERSION_FILE="${SCRIPT_DIR}/../bumpversion.cfg"
readonly GIT_FILE="${SCRIPT_DIR}/../git.cfg"

function deploy_artifacts() {
  local build_version=${1?Build version is required}
  local image_name=nexus.rozuur.com:1729/repository/docker/${APP_NAME}:${build_version}
  docker build -t "${image_name}" .
  docker push "${image_name}"
  docker rmi "$(docker images --format '{{.Repository}}:{{.Tag}}' | grep ${APP_NAME})"
}

function perform_release() {
  # Bump the version as it checks for dirty git repository
  bump2version --config-file "${VERSION_FILE}" patch

  # Create git.cfg file
  echo "[git]" > "${GIT_FILE}"
  echo "commit = $(git rev-parse --short HEAD)" >> "${GIT_FILE}"
  echo "branch = $(git branch --show-current)" >> "${GIT_FILE}"
}

function validate_release_state() {
  if [[ "${USER}" != "jenkins" ]]; then
    die "Release only happens on jenkins"
  fi
  if [[ "${GIT_BRANCH}" != "master" && "${GIT_BRANCH}" != "release" ]]; then
    die "Release can only happen with master/release branch"
  fi
}

function main() {
  "${SCRIPT_DIR}"/static_analyse.sh

  local build_version
  build_version=$(awk '/current_version/ {print $3}' "${VERSION_FILE}")

  if [[ "${RELEASE}" == "true" ]]; then
    validate_release_state
    perform_release
    deploy_artifacts "${build_version}"
  fi
}

main
