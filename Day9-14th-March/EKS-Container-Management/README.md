# Task 3: Amazon EKS Container Management

## Objective
Provision a production-grade Amazon Elastic Kubernetes Service (EKS) cluster, handle cloud capacity constraints, and deploy a containerized web application.

## Infrastructure
* Control Plane: AWS EKS Cluster (`task3-eks-cluster`).
* Worker Nodes: Managed Node Group (`fallback-nodegroup`) running on `t3.small` EC2 instances.
* Controller: Bastion Ubuntu EC2 instance with an Administrator IAM Role.
* Tools Used: AWS CLI, Kubectl, Eksctl.

## Execution Steps Completed
1. Created an Administrator IAM Role and attached it to a Bastion Ubuntu EC2 instance.
2. Installed the AWS CLI, `kubectl`, and `eksctl` on the Bastion host.
3. Provisioned the EKS cluster using `eksctl`.
4. Handled an AWS `us-east-1` capacity error (t3.medium availability) by dynamically spinning up a fallback node group using `t3.small` instances.
5. Successfully deployed the official Nginx container image to the EKS cluster.
6. Verified the active deployment and running pods using `kubectl`.
7. Executed a complete cluster teardown using `eksctl delete cluster` to prevent unnecessary AWS billing.

## Screenshots
Visual proof of the installed tools, active EKS worker nodes, running Nginx container, and the final cluster deletion can be found in the screenshots/ directory.