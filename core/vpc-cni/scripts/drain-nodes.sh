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

function kubectl-get-nodes {
  kubectl get nodes -o name --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN" $@
}

# drain all the nodes so they get the label "vpc.amazonaws.com/has-trunk-attached=true" when they restart.
# that label means that the vpc-cni is now able to attach security groups to the pods.
for node in $(kubectl-get-nodes); do
  kubectl drain ${node##*/} --ignore-daemonsets --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN"
done
