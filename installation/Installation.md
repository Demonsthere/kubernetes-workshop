# Installation guide

Since version 1.4 Kubernetes uses the `kubeadm` tool, which aims to automate and simplify the installation process. This makes the process trivial

## Assumptions:

1. Basic linux knowledge
2. A Ubuntu (> 16.04) machine

## Installation steps:

1. Update your machine
2. Install latest version of `docker.io` from the Ubuntu repositories
3. Install kubernetes following the instruction http://kubernetes.io/docs/getting-started-guides/kubeadm/
4. Instead of running `kubeadm init`, run `kubeadm join <token> <master_ip>`
5. You should now have a slave connected to the master.

