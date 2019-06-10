#!/bin/bash

source ./common.bash

helm install stable/nfs-server-provisioner --name nfs-provisioner --namespace kube-system --set storageClass.defaultClass=true

# In each worker node

sudo apt install nfs-common -y
