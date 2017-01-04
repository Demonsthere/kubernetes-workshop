#!/bin/bash

TOKEN=$1
MASTER_IP=$2

echo '---> Getting Kubernetes sources'
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo '---> Updating system'
export DEBIAN_FRONTEND noninteractive

apt-get update 
apt-get -y upgrade

echo '---> Getting Docker.io'
apt-get install -y curl docker.io

echo '---> Getting Kubernetes packages'
apt-get install -y kubelet kubeadm kubectl kubernetes-cni

echo '---> Connecting to master'
kubeadm join --token=$TOKEN $MASTER_IP
