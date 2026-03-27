# 🚀 Day 2: Terraform State & AWS Remote Backend

Welcome to **Day 2** of my **Terraform 30 Days Challenge**! After provisioning our first resource, today focuses on securely managing infrastructure state using an S3 remote backend.

## 🌟 Overview
Terraform stores the state of managed infrastructure in a `.tfstate` file. By default, this is stored locally, which is undesirable for team collaboration and security. Today, I configured an **S3 Remote Backend** to store the state securely in an AWS S3 bucket.

### 📚 Topics Covered
- **Terraform Providers**: Understanding how plugins allow Terraform to interact with APIs.
- **Provider Versioning**: Best practices for version constraints using Operators (`=`, `>=`, `~>`).
- **State Management**: The purpose of the `terraform.tfstate` file.
- **Remote Backend Setup**: Migrating local state to an AWS S3 remote backend.
- **State Locking**: Using `use_lockfile = true` to prevent concurrent modifications.

## 🛠️ Infrastructure Configuration

### What was Implemented?
Instead of creating basic resources, the `terraform` block was updated to use a remote backend.

```hcl
terraform {
  # Remote backend configuration
  backend "s3" {
    bucket       = "aung-saw-bucket-30"
    key          = "dev/terraform.tfstate"
    region       = "ap-southeast-1"
    profile      = "dev"
    encrypt      = true
    use_lockfile = true
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

## 🚀 Execution Steps
To initialized this backend configuration:

1. **Initialize the backend configuration**:
   ```bash
   terraform init
   ```
   *If migrating from a local state, Terraform will prompt you to copy the state to S3.*
2. **Validate the configuration**:
   ```bash
   terraform validate
   ```
3. **Run a plan to verify**:
   ```bash
   terraform plan
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Stay tuned for Day 3 as we dive deeper into variables and outputs! 💪*
