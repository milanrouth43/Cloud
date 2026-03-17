# Jenkins CI/CD Pipeline Setup on AWS EC2

## Objective
This project demonstrates the manual setup and configuration of a Jenkins server on a dedicated AWS EC2 RedHat instance. It includes the creation of a chained CI/CD job pipeline with scheduling and remote triggering capabilities.

## Infrastructure & Prerequisites
* **Cloud Provider:** AWS
* **OS:** Red Hat Enterprise Linux (RHEL 9)
* **Instance Type:** t2.micro
* **Tools:** Jenkins, Java 17 (Amazon Corretto)

## Tasks Completed
1. **Infrastructure Setup:** Provisioned an AWS EC2 instance and configured Security Groups to allow SSH (22) and Jenkins UI access (8080).
2. **Jenkins Installation:** Installed Java 17 and configured the Jenkins package repository on RHEL.
3. **Job Creation:** Created three dedicated Freestyle jobs:
   * `1-Build`
   * `2-Test`
   * `3-Deploy`
4. **Job Ordering (Chaining):** Configured Post-build Actions so that a successful Build triggers Test, and a successful Test triggers Deploy.
5. **Scheduling:** Configured Cron syntax (`* * * * *`) to automatically trigger the pipeline periodically.
6. **Remote Triggering:** Generated an authentication token to allow pipeline execution via remote HTTP POST requests.

## Screenshots
All visual proof of the configuration and successful execution can be found in the `screenshots/` directory.