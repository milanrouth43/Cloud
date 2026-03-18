# Kubernetes Task 3: Helm Chart Management and Rollbacks

## Objective
The goal of this task is to use Helm, the Kubernetes package manager, to create, deploy, upgrade, and rollback a custom application chart (`student-app`). 

## Tech Stack
* **Environment:** Minikube on AWS EC2
* **Tooling:** `helm`, `kubectl`, `vi` editor

## Tasks Completed
1. **Helm Installation:** Downloaded and installed the Helm v3 CLI tool.
2. **Chart Creation:** Generated a default Helm chart structure named `student-app`.
3. **Initial Deployment:** Modified the `values.yaml` file to set `replicaCount: 2` and deployed the release using `helm install`. Verified 2 pods were running.
4. **Upgrade Release:** Modified the `values.yaml` file to scale the `replicaCount` to `4` and applied the changes using `helm upgrade`. Verified 4 pods were running.
5. **History & Rollback:** Checked the deployment history using `helm history` to view the revisions. Executed a `helm rollback` to revert the application back to Revision 1 (2 pods).
6. **Final Verification:** Verified the pods scaled back down to 2 and that the history reflected the rollback action.

## Screenshots
Visual proof of the installation, upgrade (scaling), history tracking, and successful rollback can be found in the `screenshots/` directory.