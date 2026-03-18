# Task 1: Prometheus & Grafana EC2 Monitoring Setup

## Objective
Deploy a complete monitoring and observability stack using two AWS EC2 instances to track system metrics and visualize them in real-time.

## Infrastructure
* App-Server (Patient): Amazon Linux (t3.micro) running Node Exporter on port 9100 to expose system metrics.
* Monitor-Server (Doctor & Screen): Amazon Linux (t3.medium) running the Prometheus server (port 9090) to scrape metrics, and Grafana (port 3000) for data visualization.

## Execution Steps Completed
1. Provisioned two EC2 instances and configured Security Groups to allow custom TCP ports 9100, 9090, and 3000.
2. Installed and launched Node Exporter as a background process on the App-Server.
3. Installed Prometheus on the Monitor-Server and edited the prometheus.yml file to configure the App-Server as a scraping target.
4. Verified metrics scraping by querying the process_cpu_seconds_total metric inside Prometheus.
5. Installed Grafana on the Monitor-Server, connected Prometheus as the data source via localhost, and imported the official Node Exporter Full dashboard (ID: 1860).

## Screenshots
Visual proof of the running services, targets, internal Prometheus graphs, and final Grafana dashboard can be found in the screenshots/ directory.