#!/usr/bin/env bash
#
if [ ${#} -ne 1 ]; then
    echo "Usage: ${0} ISTIO_VERSION" >>/dev/stderr
    exit 1
fi

set -euo pipefail

ISTIO_VERSION=${1}
ISTIO_DL_PATH=.istio-download

if [ ! -d ${ISTIO_DL_PATH}/istio-${ISTIO_VERSION} ]; then
  mkdir -p ${ISTIO_DL_PATH}; cd ${ISTIO_DL_PATH}
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} sh - >> /dev/null 2>&1
fi

echo "{\"path\":\"${ISTIO_DL_PATH}/istio-${ISTIO_VERSION}\"}"
