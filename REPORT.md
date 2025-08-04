# 🚀 DevOps CI/CD Case Study – Node.js App on AWS

This report explains the full process of implementing an automated DevOps pipeline to deploy a Node.js application on an AWS EC2 instance using GitHub, Docker, Terraform, Ansible, and Jenkins.

---

## 🔗 GitHub Repository

- **Repository**: [https://github.com/Sahil3908/myapp-devops-pipeline](https://github.com/Sahil3908/myapp-devops-pipeline)
- **Branches**:
  - `main` – Production-ready code (protected)
  - `develop` – Development and testing

---

## 🔧 Project Workflow Overview

1. **Code Development & Push**:
   - Code is pushed to the `develop` branch.
   - GitHub triggers Jenkins pipeline using a webhook.

2. **CI/CD Pipeline (Jenkins)**:
   - Checkout code from GitHub
   - Build Docker image
   - Push Docker image to DockerHub
   - Provision infrastructure using Terraform
   - Configure EC2 instance using Ansible
   - Deploy Node.js app on EC2

![Web App UI](images/web-app-ui.png)

🏗️ Infrastructure Setup (Terraform)
Terraform scripts are written in the infra/ folder.

Resources Created:
VPC, public subnet

Internet Gateway, route tables

Security Group (allows port 22 & 80)

EC2 instance (t2.micro with Elastic IP)

Terraform Commands:
cd infra
terraform init
terraform plan
terraform apply -auto-approve

🐳 Docker Image Creation
A Dockerfile is used to containerize the Node.js application.

Docker Steps:
bash
Copy
Edit
docker build -t sahilc08/myapp:latest .
docker login
docker push sahilc08/myapp:latest

📦 Configuration Management (Ansible)
Ansible is used to:

Install Docker on EC2

Login to DockerHub

Pull the Node.js image

Run the container on port 80

Ansible Playbook Command:

ansible-playbook -i inventory deploy.yml -e "docker_user=sahilc08 docker_password=yourpassword"

⚙️ Jenkins Pipeline Execution
Jenkins is configured with a webhook to GitHub and executes the CI/CD process with the following stages:

Checkout

Build (Docker)

Terraform Apply

Ansible Deploy

🐞 Errors Faced & Fixes

Jenkins stuck at “Gathering Facts” during Ansible playbook

✅ Fix: Restarted EC2 instance, cleared Docker cache using docker system prune -a, and increased memory allocation.

Ansible Docker login failed

✅ Fix: Used extra vars -e flag to pass DockerHub username and password securely in the CLI.

Terraform apply timed out or hung on EC2 provisioning

✅ Fix: Verified SSH key pair, ensured correct AMI ID, and selected an available availability zone (ap-south-1a).

Docker build failing due to permission errors

✅ Fix: Ran Docker commands with sudo, added user to docker group, and restarted Docker daemon.

EC2 instance not accessible via public IP

✅ Fix: Checked security group rules — added inbound rules for port 22 (SSH) and port 80 (HTTP).

Jenkins build failing at Git checkout stage

✅ Fix: Installed Git plugin in Jenkins and configured the Git path in Jenkins system settings.

WSL2 crashing while building Docker image

✅ Fix: Cleared unnecessary files in WSL, especially .vscode-server, and restarted the WSL2 subsystem.

Docker container not starting on EC2

✅ Fix: Checked Ansible logs, verified image pull from DockerHub, and ensured ports were exposed properly in the Dockerfile.
