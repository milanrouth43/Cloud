# Kubernetes Task 2: Core Resource YAML Manifests

## Objective
The goal of this task is to understand and deploy the core building blocks of Kubernetes using declarative YAML manifests. All resources were created and isolated within a dedicated custom namespace.

## Tech Stack
* **Environment:** Minikube (Single-Node Cluster) on AWS EC2
* **Tooling:** `kubectl`, `vi` editor
* **Configuration:** YAML

## Tasks Completed
Successfully wrote and applied 9 YAML manifests and verified the cluster node to fulfill the 10 required components:
1. **Namespace:** Created a dedicated namespace named `dev` to logically isolate all following resources.
2. **Pod:** Deployed a standalone Nginx pod as the smallest deployable unit.
3. **ConfigMap:** Created a ConfigMap (`app-config`) to store non-sensitive configuration data (e.g., APP_MODE).
4. **Secret:** Created an Opaque Secret (`db-secret`) to securely store base64-encoded credentials.
5. **Service:** Configured a ClusterIP Service (`web-svc`) to provide stable internal networking to the Nginx pods.
6. **Ingress:** Enabled the Minikube Ingress addon and defined routing rules to expose the service to external traffic.
7. **Deployment:** Deployed a stateless application (`nginx-deploy`) with rolling update capabilities.
8. **ReplicaSet:** Deployed a ReplicaSet (`nginx-rs`) to ensure a specified number of pod replicas are running at any given time.
9. **DaemonSet:** Deployed a DaemonSet (`monitoring-daemon` using busybox) to ensure a copy of the pod runs on all cluster nodes for monitoring purposes.
10. **Nodes:** Verified the underlying Minikube node infrastructure using `kubectl get nodes`.

## Verification
All resources were verified as running successfully within the `dev` namespace using the `kubectl get all -n dev` command. Proof of execution can be found in the `screenshots/` directory.