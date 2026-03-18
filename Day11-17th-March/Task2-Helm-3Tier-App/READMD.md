# Task 2: 3-Tier Application Deployment using Helm

## Objective
Deploy a 3-tier web application (Nginx Frontend, Nginx Backend, PostgreSQL Database) on a single-node Kubernetes cluster and manage its lifecycle using Helm.

## Infrastructure
* Host: AWS EC2 Instance running Ubuntu 22.04 LTS (t2.medium).
* Cluster: Minikube (Docker driver).
* Tools Used: Docker, Kubectl, Helm 3.

## Execution Steps Completed
1. Provisioned the EC2 instance and installed Docker, Minikube, Kubectl, and Helm.
2. Initialized a Minikube cluster and created a base Helm chart (`three-tier-app`).
3. Cleared default Helm templates and created custom Kubernetes manifests (Deployments and Services) for the frontend, backend, and database tiers.
4. Linked the frontend replica count to `values.yaml` and deployed the release.
5. Exposed the frontend service via NodePort (32133) and verified accessibility through the browser using port-forwarding.
6. Successfully demonstrated Helm's lifecycle management by upgrading the release (scaling frontend replicas from 2 to 3) and rolling back to the previous revision.

## Screenshots
Visual proof of the running cluster, active pods/services, live web interface, and scale/rollback commands can be found in the screenshots/ directory.