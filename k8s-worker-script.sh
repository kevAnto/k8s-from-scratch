#!/bin/bash

#Passing enterings nodes names to ip maping on every nodes
sudo swapoff -a
# sudo vim /etc/hosts
# 10.0.10.21 controlplane
# 10.0.20.203 workernode

#Place your on controlplan and set for controlplan also do same for workers
# sudo hostnamectl set-hostname controlplane
sudo hostnamectl set-hostname workernode

#Install a container runtime
# Enable IPv4 packet forwarding https://kubernetes.io/docs/setup/production-environment/container-runtimes/#prerequisite-ipv4-forwarding-optional
# Install Containerd https://github.com/containerd/containerd/blob/main/docs/getting-started.md#option-2-from-apt-get-or-dnf

wget https://raw.githubusercontent.com/kevAnto/k8s-from-scratch/main/containerd-install.sh
chmod u+x ./containerd-install.sh
./containerd-install.sh
service containerd status

#Install kubeadm, kubelet and kubectl

wget https://raw.githubusercontent.com/kevAnto/k8s-from-scratch/main/k8s-install.sh
chmod u+x ./k8s-install.sh
./k8s-install.sh

sudo apt-mark hold kubelet kubeadm kubectl
kubeadm version
service kubelet status

