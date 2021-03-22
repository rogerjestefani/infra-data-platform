# infra-data-platform

terraform init


export GOOGLE_CREDENTIALS='/home/roger/Downloads/infra.json'


SSH TUNNEL

 $ gcloud beta compute ssh example-instance --zone=us-central1-a -- \
            -vvv -L 80:%INSTANCE%:80

gcloud beta compute ssh --zone "us-east1-b" "bastion" --tunnel-through-iap --project "abiding-window-307913" -- -vnNT -L 8443:10.0.0.2:443

gcloud container clusters get-credentials gke-cluster --zone us-east1-b --project abiding-window-307913

kubectl config set-cluster "gke-cluster-local" --insecure-skip-tls-verify=true --server="https://127.0.0.1:8443"
kubectl config set-context "gke-cluster-local" --cluster="gke-cluster-local" --user="gke_abiding-window-307913_us-east1-b_gke-cluster"
kubectl config use-context "gke-cluster-local"


