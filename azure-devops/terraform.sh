#!/bin/bash

set -e

#
# HOW TO USE IT:
# $ sh terraform.sh apply core -> to apply terraform file inside core-projects
# $ sh terraform.sh apply idpay -> to apply terraform file inside idpay-projects
#

SCRIPT_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CURRENT_DIRECTORY="$(basename "$SCRIPT_PATH")"
ACTION=$1
PROJECT=$2
shift 2
other="$*"
BACKEND_CONFIG_PATH="../.env/${PROJECT}_state.tfvars"
BACKEND_INI_PATH="../.env/prod-backend.ini"
TF_VAR_FILE_PATH="../.env/terraform.tfvars"

echo "[INFO] This is the current directory: ${CURRENT_DIRECTORY}"

if [ -z "$ACTION" ]; then
  echo "[ERROR] Missed ACTION: init, apply, plan"
  exit 0
fi

if [ -z "$PROJECT" ]; then
  echo "[ERROR] PROJECT should be: app or iac."
  exit 0
fi

pushd "${PROJECT}-projects"

# LOAD SUBSCRIPTION
## must be subscription in lower case
subscription=""
# shellcheck source=/dev/null
source "${BACKEND_INI_PATH}"

az account set -s "${subscription}"

if echo "init plan apply refresh import output state taint destroy" | grep -w "$ACTION" > /dev/null; then
  if [ "$ACTION" = "init" ]; then
    echo "[INFO] 🧭 init terraform"
    terraform "$ACTION" -backend-config="${BACKEND_CONFIG_PATH}" "$other"
  elif [ "$ACTION" = "output" ] || [ "$ACTION" = "state" ] || [ "$ACTION" = "taint" ]; then
    # init terraform backend
    terraform init -reconfigure -backend-config="${BACKEND_CONFIG_PATH}"
    terraform "$ACTION" "$other"
  else
    # init terraform backend
    echo "[INFO] 🧭 init terraform"
    terraform init -reconfigure -backend-config="${BACKEND_CONFIG_PATH}"

    echo "[INFO] 🧭 run terraform with: ${ACTION} and other: >${other}<"
    terraform "${ACTION}" -var-file="${TF_VAR_FILE_PATH}" $other
  fi
else
    echo "[ERROR] ACTION not allowed."
    exit 1
fi
