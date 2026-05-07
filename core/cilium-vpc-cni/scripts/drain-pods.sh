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

function kubectl-get-namespaces {
  kubectl get ns -o jsonpath='{.items[*].metadata.name}' --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN"
}

function kubectl-get-cep {
  ns=$1
  kubectl get -n "${ns}" get cep -o jsonpath='{.items[*].metadata.name}' --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN"
}

function kubectl-get-pod-network {
  ns=$1
  kubectl -n "${ns}" get pod -o custom-columns=NAME:.metadata.name,NETWORK:.spec.hostNetwork \
           --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN" \
           | grep -E '\s(<none>|false)' | awk '{print $1}' | tr '\n' ' '
}

function kubectl-delete-pod {
  ns=$1
  pod=$2
  kubectl -n "${ns}" delete pod ${pod} --kubeconfig $CONFIG_FILE --server $CLUSTER_ENDPOINT --certificate-authority $CA_FILE --token "$CLUSTER_TOKEN"
}

# Restart existing pods
for ns in $(kubectl-get-namespaces); do
  ceps=$(kubectl-get-cep $ns)
  pods=$(kubectl-get-pod-network $ns)
  ncep=$(echo "${pods} ${ceps}" | tr ' ' '\n' | sort | uniq -u | paste -s -d ' ' -)
  for pod in $(echo $ncep); do
    kubectl-delete-pod ${ns} ${pod}
  done
done
