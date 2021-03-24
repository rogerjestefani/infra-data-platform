#!/bin/bash
gcloud beta compute ssh --zone "us-east1-b" "bastion" --tunnel-through-iap --project "${GOOGLE_CLOUD_PROJECT}" -- -vnNT -L 8443:10.5.0.2:443