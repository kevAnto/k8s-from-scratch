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

 * Locate the Kubeconfig File:
The Kubeconfig file for k8s is usually located at /etc/rancher/k8s/k8s.yaml.

`sudo cat /etc/rancher/k8s/k8s.yaml`

 * Modify the Server Address:
The k8s.yaml file will have a server field that looks like https://127.0.0.1:6443. You need to change this to point to the public IP address or DNS name of your EC2 instance.

 * Setup KUBECONFIG Environment Variable
 place your k8s-ec2-kubeconfig.yaml file is in your home directory and do:

`export KUBECONFIG=~/k8s-ec2-kubeconfig.yaml`