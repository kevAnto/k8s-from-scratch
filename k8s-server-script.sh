#!/bin/bash

sudo swapoff -a

set -e

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt-get update -y
sudo apt-get upgrade -y

sudo su
apt update
curl -sfL https://get.k8s.io | sh -
apt install docker.io -y
systemctl status k8s
# sudo cat /var/lib/rancher/k8s/server/node-token

# curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
