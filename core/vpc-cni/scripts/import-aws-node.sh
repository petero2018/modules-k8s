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

function kubectl-annotate {
  kubectl annotate -n kube-system --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN" $@
}

function kubectl-label {
  kubectl label -n kube-system --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN" $@
}

# don't import the crd. Helm can't manage the lifecycle of it anyway.
for kind in daemonSet clusterRole clusterRoleBinding serviceAccount; do
  echo "setting annotations and labels on $kind/aws-node"
  kubectl-annotate --overwrite $kind aws-node meta.helm.sh/release-name=aws-vpc-cni
  kubectl-annotate --overwrite $kind aws-node meta.helm.sh/release-namespace=kube-system
  kubectl-label --overwrite $kind aws-node app.kubernetes.io/managed-by=Helm
done
