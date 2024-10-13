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

# Install celuim (quick install cli)
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

cilium install --set ipam.operator.clusterPoolIPv4PodCIDRList="10.0.0.0/9"
kubectl get node
kubectl get po -n kube-system

# cmd to get output for workernode to join cluster
# kubeadm token create --print-join-command

kubectl get po -A | grep cilium
kubectl -n kube-system exec cilium-r9265 -- cilium-dbg status