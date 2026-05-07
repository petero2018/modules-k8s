#!/bin/bash

#CLUSTER_ENDPOINT
#CLUSTER_CA
#CLUSTER_TOKEN

until curl -k -s $CLUSTER_ENDPOINT/healthz >/dev/null; do sleep 4; done

MANIFEST_FILE=`mktemp`
CONFIG_FILE=`mktemp`
CA_FILE=`mktemp`

trap "{ rm -f $MANIFEST_FILE $CONFIG_FILE $CA_FILE; }" EXIT

echo $CLUSTER_CA | base64 -d > $CA_FILE

function kubectl-get-status {
  kubectl get ${RESOURCE} -n "${NAMESPACE}" "${NAME}" -o jsonpath="{${JSON_PATH}}" --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN"
}

TIME=0
while [ "$(kubectl-get-status)" != "${EXPECTED_VALUE}" ]; do
  sleep ${STEP_TIME}
  TIME=$((TIME+$STEP_TIME))
  if [ "$TIME" -gt "$TIMEOUT" ]; then
    echo "${ERROR_MESSAGE}"
    exit 1
  fi
done
