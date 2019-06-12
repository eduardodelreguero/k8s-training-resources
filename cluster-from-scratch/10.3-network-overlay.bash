#!/bin/bash

source ./common.bash

# To run on the client (where admin context is present)

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

