# Automated Jenkins Pipeline with GitHub Webhooks

## Objective
This project demonstrates a fully automated CI/CD pipeline using Jenkins and GitHub. It utilizes a `Jenkinsfile` (Pipeline-as-Code) to define the build stages and a GitHub Webhook to automatically trigger the pipeline whenever new code is pushed to the repository.

## Tech Stack & Prerequisites
* **Cloud Provider:** AWS EC2 (Red Hat Enterprise Linux 9)
* **CI/CD Tool:** Jenkins
* **Version Control:** Git & GitHub
* **Language/Environment:** Java (Amazon Corretto 17)

## Pipeline Architecture
The pipeline is defined in the `Jenkinsfile` and consists of three distinct stages:
1. **Build:** Compiles the Java source code (`javac`).
2. **Test:** Executes a basic Java test script to validate logic (`java`).
3. **Deploy:** Simulates a deployment by creating a directory and copying the compiled `.class` artifacts into it.

## Automation Workflow
1. A developer pushes code changes to the `main` branch of this GitHub repository.
2. The GitHub Webhook immediately sends a JSON payload to the Jenkins server endpoint (`/github-webhook/`).
3. Jenkins intercepts the payload, matches it to the `Auto-Java-Pipeline` job, and automatically pulls the latest code.
4. Jenkins executes the stages defined in the `Jenkinsfile` without any manual intervention.

## Screenshots
Visual proof of the Webhook configuration, Jenkins job setup, and the successful automated pipeline execution can be found in the `screenshots/` directory.