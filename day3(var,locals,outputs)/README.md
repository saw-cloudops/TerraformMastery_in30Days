# 🚀 Day 3: Variables, Locals, and Outputs in Terraform

Welcome to **Day 3** of my **Terraform 30 Days Challenge**! Today, the focus is on making Terraform code dynamic, reusable, and easier to manage using Variables, Locals, and Outputs.

## 🌟 Overview
Hardcoding values (like region names, instance types, or CIDR blocks) in Terraform is not best practice. Instead, we use **Input Variables** to parameterize configurations, **Local Values** to avoid repeating expressions, and **Outputs** to extract useful information after a deployment.

### 📚 Topics Covered
- **Input Variables (`variable`)**: Passing dynamic values (like environment names) to make modules reusable.
- **Local Values (`locals`)**: Assigning a name to an expression or value to use multiple times within a module (e.g., standardizing tags).
- **Output Values (`output`)**: Exporting details about provisioned resources (e.g., an EC2 public IP or S3 bucket name).

## 🛠️ Infrastructure Setup

### What was Created?
Using `var` and `local` references, the following resources were provisioned dynamically:
1. **AWS VPC**: A virtual network (`dev-vpc`).
2. **AWS EC2 Instance**: A standard `t2.micro` compute instance (`dev-instance`).
3. **AWS S3 Bucket**: A storage bucket (`ash-bucket-50`).

```hcl
# Example of Variable & Local usage
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = var.enviroment
    Name        = "${local.tag_name}-vpc"
  }
}
```

## 🚀 Execution Steps
To execute this code and override variables:

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Review Execution Plan**:
   ```bash
   terraform plan
   ```
3. **Apply & Pass Variables via CLI** (Optional):
   ```bash
   terraform apply -var="enviroment=stage"
   ```
   *Alternatively, you can use environment variables (e.g., `export TF_VAR_enviroment=stage`).*

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*More to come on Day 4: Project Structure! 💪*
