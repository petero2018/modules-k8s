#!/usr/bin/env bash

set -e
set -o pipefail

run_kustomize() {
    if (command -v kustomize 1>/dev/null 2>&1); then
        echo "Running kustomize using separate binary" >&2
        kustomize build "$@"
    elif (command -v kubectl 1>/dev/null 2>&1); then
        echo "Running kustomize using kubectl" >&2
        kubectl kustomize "$@"
    else
        echo "ERROR: Cannot run kustomize. Please install kustomize or kubectl" >&2
        exit 1
    fi
}

OVERLAY_DIR=$(dirname "${1}")

cat <&0 >"${OVERLAY_DIR}/base.yaml"
run_kustomize "${OVERLAY_DIR}" && rm "${OVERLAY_DIR}/base.yaml"
