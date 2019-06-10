#!/bin/bash

source ./common.bash

export COREDNS_WORKING_FOLDER=/tmp/coredns
mkdir -p $COREDNS_WORKING_FOLDER

# Download source files

wget "https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/coredns/Makefile" -P $COREDNS_WORKING_FOLDER

wget "https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/coredns/coredns.yaml.base" -P $COREDNS_WORKING_FOLDER
wget "https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/coredns/coredns.yaml.in" -P $COREDNS_WORKING_FOLDER
wget "https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/coredns/transforms2salt.sed" -P $COREDNS_WORKING_FOLDER
wget "https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/coredns/transforms2sed.sed" -P $COREDNS_WORKING_FOLDER

# Install required software

# Linux
sudo apt install make

# Mac
brew install gettext
brew link --force gettext

# Set the required environment variables

export DNS_SERVER_IP=$COREDNS_SERVICE_IP
export DNS_DOMAIN=$CLUSTER_DOMAIN
export SERVICE_CLUSTER_IP_RANGE=$SERVICE_CLUSTERIP_NET
export DNS_MEMORY_LIMIT=200Mi

# Generate the yaml

cd $COREDNS_WORKING_FOLDER
make
envsubst < coredns.yaml.sed  > coredns.yaml

# Deploy the yaml

kubectl apply -f coredns.yaml