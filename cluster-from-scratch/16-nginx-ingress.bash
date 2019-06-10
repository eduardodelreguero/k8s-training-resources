#!/bin/bash

source ./common.bash

helm install stable/nginx-ingress --name nginx-ingress --set rbac.create=true --namespace kube-system --set controller.hostNetwork=true --set controller.kind=DaemonSet