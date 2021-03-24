#!/bin/bash

gcloud container clusters get-credentials gke-cluster --zone us-east1-b --project ${GOOGLE_CLOUD_PROJECT}

kubectl config set-cluster "gke-cluster-local" --insecure-skip-tls-verify=true --server="https://127.0.0.1:8443"
kubectl config set-context "gke-cluster-local" --cluster="gke-cluster-local" --user="gke_${GOOGLE_CLOUD_PROJECT}_us-east1-b_gke-cluster"
kubectl config use-context "gke-cluster-local"
