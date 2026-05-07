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

if kubectl get sc gp2 --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN" ; then
    kubectl delete sc gp2 --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN"
else
    echo "StorageClass 'gp2' not found, skipping deletion."
fi
