#!/bin/bash

#Passing enterings nodes names to ip maping on every nodes
sudo swapoff -a
# sudo vim /etc/hosts
# 10.0.10.247 controlplane
# 10.0.20.95 workerNode

#Place your on controlplan and set for controlplan also do same for workers
sudo hostnamectl set-hostname controlplane
# sudo hostnamectl set-hostname workerNode

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

# kubectl version
# kubelet --version
# kubeadm version
# service kubelet status

#After passing enterings nodes names to ip maping on every nodes
sudo kubeadm init
sudo kubectl get node --kubeconfig /etc/kubernetes/admin.conf
#sudo -i
#export KUBECONFIG=/etc/kubernetes/admin.conf
mkdir -p ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config