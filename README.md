# terraform-code-to-run-k8s-on-an-ec2
Prerequisites
An AWS account. If you don’t have one, you can register here.

A key pair. If you don’t have one, refer to Creating a key pair.

An AWS IAM User with programmatic key access and permissions to launch EC2 instances


Steps for the project

* Set your remote state
* terraform init
* terraform apply

Access the Kubeconfig File on the EC2 Instance
 * SSH into the EC2 Instance 
 * Passing enterings nodes names to ip maping on every nodes
       sudo vim /etc/hosts
       10.0.10.247 controlplane
       10.0.20.95 workerNode

https://docs.cilium.io/en/v1.14/gettingstarted/k8s-install-default/#k8s-install-quick

