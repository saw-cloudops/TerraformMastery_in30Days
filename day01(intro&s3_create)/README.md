# 🚀 Day 1: Introduction to Terraform & AWS S3 Creation

Welcome to **Day 1** of my **Terraform 30 Days Challenge**! Today marks the beginning of my journey into Infrastructure as Code (IaC) with HashiCorp Terraform.

## 🌟 Overview
In this module, I explored the basics of Terraform, its workflow, and provisioned my very first AWS resource—an Amazon S3 bucket.

### 📚 Topics Covered
- Understanding **Infrastructure as Code (IaC)** and its benefits.
- Why modern DevOps uses IaC (Consistency, Time Efficiency, Cost Management, Scalability).
- What is **Terraform** and how it interacts with Cloud Providers via APIs.
- The core **Terraform Workflow** (`init`, `plan`, `apply`, `destroy`).
- Installing and configuring Terraform on a local machine.
- Writing my first `.tf` file to provision an AWS S3 bucket.

## 🛠️ Infrastructure Setup

### What was Created?
1. **AWS S3 Bucket**: An Amazon S3 bucket (`ash-test-bucket30`) configured via the `aws` provider.

```hcl
# main.tf snippet
resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "ash-test-bucket30"

  tags = {
    Name        = "my_first_bucket"
    Environment = "Dev"
  }
}
```

## 🚀 Execution Steps
To deploy this infrastructure, follow these commands:

1. **Initialize the working directory** (downloads the AWS provider):
   ```bash
   terraform init
   ```
2. **Format and validate the code**:
   ```bash
   terraform fmt
   terraform validate
   ```
3. **Review the execution plan**:
   ```bash
   terraform plan
   ```
4. **Apply to provision the resources in AWS**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Follow along as I continue deploying and mastering infrastructure automation! 💪*
