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
bash
Copy
Edit
ansible-playbook -i inventory deploy.yml -e "docker_user=sahilc08 docker_password=yourpassword"

⚙️ Jenkins Pipeline Execution
Jenkins is configured with a webhook to GitHub and executes the CI/CD process with the following stages:

Checkout

Build (Docker)

Terraform Apply

Ansible Deploy

🐞 Errors Faced & Fixes
❌ Error / Issue	🛠️ Solution
Jenkins stuck at “Gathering Facts”	Restarted EC2, pruned Docker system, ensured sufficient memory
Docker login failed in Ansible	Passed credentials using -e flags and ensured correct DockerHub creds
Terraform timeout on EC2	Checked SSH key pair, verified EC2 instance availability zone
WSL2 crash during build	Removed .vscode-server from WSL and restarted terminal
EC2 not accessible from browser	Verified security group settings to allow HTTP (80) and assigned Elastic IP
Jenkins pipeline failed on git clone	Installed Git plugin and configured Git executable in Jenkins
