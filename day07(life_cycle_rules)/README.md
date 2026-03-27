# 🚀 Day 7: AWS Highly Available Web Architecture & Lifecycle Rules

Welcome to **Day 7** of my **Terraform 30 Days Challenge**! 

[![Terraform](https://img.shields.io/badge/Terraform-v1.x-623CE4?style=for-the-badge&logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-232F3E?style=for-the-badge&logo=amazon-aws)](https://aws.amazon.com/)

A completely automated, fault-tolerant, and perfectly scalable web architecture deployed on AWS using **Infrastructure as Code (IaC)** with Terraform.

## 🌟 Architecture Overview
This Terraform configuration automatically provisions:
- **🖧 Secure Networking:** A custom VPC, Internet Gateway, and dual Public Subnets spanning across different Availability Zones (High Availability).
- **🚦 Application Load Balancer (ALB):** Effortlessly distributes incoming HTTP internet traffic across a dynamic pool of instances.
- **🛡️ Custom Security Groups:** 
  - The ALB receives traffic exclusively from the internet.
  - The ASG instances receive traffic exclusively from the ALB via Port 80 and allow SSH (Port 22).
- **🚀 Auto Scaling Group (ASG):** Powered by an AWS Launch Template that seamlessly bootstraps brand new EC2 Amazon Linux instances.
- **⚙️ Nginx Bootstrapping:** A robust `user_data` bash script that seamlessly injects and starts Nginx on server creation.

## 🛠️ Tech Stack & Key Features
- **Terraform:** Variables, outputs, merge functions, and dynamic blocks.
- **Highly Available & Auto-Healing Target Groups:** Automatic health checks with grace periods gracefully replace failing instances without any intervention.
- **Zero Downtime Deployments:** Utilizes Terraform **`lifecycle`** blocks (`create_before_destroy = true`) for safe replacement of resources without impacting application availability.

## ⚙️ How to Deploy
**Prerequisites:** Ensure you have Terraform installed and your AWS CLI configured.

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```
2. **Validate and plan the infrastructure:**
   ```bash
   terraform plan
   ```
3. **Apply to AWS:**
   ```bash
   terraform apply --auto-approve
   ```
4. **Verify:**
   Grab the `alb_dns_name` provided in the Terraform Outputs and paste it into your browser. You will be greeted by the Nginx welcome screen confirming the setup!
5. **Cleanup:**
   ```bash
   terraform destroy --auto-approve
   ```

## 🎯 Challenges Overcome
During development, I encountered routing and availability obstacles such as a **504 Gateway Timeout**. By deep diving into AWS Security Group topologies, I diagnosed a strict outbound packet filter blackholing my Load Balancer's outbound TCP probes, ultimately stabilizing health checks.

## 🔗 Connect with Me
I am actively sharing my cloud engineering journey. Let's connect!
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Moving forward to Day 8 to explore dynamic blocks and conditions! 💪*
