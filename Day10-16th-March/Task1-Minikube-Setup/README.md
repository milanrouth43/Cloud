# Kubernetes Task 1: Minikube Cluster Setup

## Objective
The goal of this task is to provision the required infrastructure and install a single-node Kubernetes cluster using Minikube to prepare for deploying Kubernetes resources.

## Infrastructure & Prerequisites
* **Cloud Provider:** AWS EC2
* **OS:** Ubuntu 24.04 LTS
* **Instance Type:** m7i-flex.large 
* **Tools Installed:** Docker, Minikube, Kubectl

## Execution Steps Completed
1. Provisioned the EC2 instance and connected via SSH.
2. Installed Docker (`docker.io`) and added the `ubuntu` user to the Docker group to act as the container runtime.
3. Downloaded and installed the Minikube Linux binary.
4. Installed `kubectl` via Snap to manage the cluster.
5. Initialized the cluster using the Docker driver (`minikube start --driver=docker`).
6. Verified cluster health using `kubectl get nodes`.

## Screenshots
Proof of the active instance, Docker installation, and healthy Minikube node can be found in the `screenshots/` directory.