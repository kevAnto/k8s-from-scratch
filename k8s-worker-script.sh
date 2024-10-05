#!/bin/bash

set -e

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt-get update -y
sudo apt-get upgrade -y

sudo su
apt update
apt install docker.io -y
systemctl status docker

# curl -sfL https://get.k8s.io | k8s_URL=https://<MasterNodePublicIP>:6443 k8s_TOKEN=<NodeToken> sh -

# kubectl get nodes

# hostnamectl set-hostname worker-node-1
# echo worker-node-1 > /etc/hostname
# kubectl delete node worker-node-1

# curl -sfL https://get.k8s.io | k8s_URL=https://<MasterNodePublicIP>:6443 k8s_TOKEN=<NodeToken> sh -
# export k8s_URL=https://x.x.x.x:6443
# k8s_TOKEN=
# curl -sfL https://get.k8s.io |  sh -