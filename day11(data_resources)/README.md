# 🚀 Day 11: Data Sources in Terraform

Welcome to **Day 11** of my **Terraform 30 Days Challenge**! Today is focused on exploring **Data Sources**, which allow Terraform to fetch data from the cloud provider (AWS) or other external systems dynamically.

## 🌟 Overview
In enterprise environments, you don't always build everything from scratch. Often, you need to deploy resources (like EC2 instances) into an environment (like a VPC or Subnet) that was automatically provisioned by another team. **Data Sources** enable us to retrieve the IDs and configurations of these existing resources without hardcoding them.

### 📚 Topics Covered
- **Data Blocks (`data`)**: Fetching read-only information from AWS.
- **Filters**: Using `filter {}` blocks to pinpoint specific resources by tags or attributes.
- **Dynamic AMIs**: Fetching the latest Amazon Linux 2 AMI dynamically, ensuring the configuration stays up-to-date and works across multiple regions.

## 🛠️ Infrastructure Setup

### What was Created?
1. **Data Lookups**: Queries AWS for an existing VPC by ID and an existing Subnet by filtering on a specific tag (`Name = "shared-primary-subnet"`).
2. **EC2 Deployment**: Provisions a brand new AWS EC2 instance precisely into that existing Subnet and assigns it a specific private IP.

```hcl
# Example of using a Data Source to find an existing Subnet
data "aws_subnet" "shared" {
  filter {
    name   = "tag:Name"
    values = ["shared-primary-subnet"]
  }
  vpc_id = data.aws_vpc.shared.id
}
```

## 🚀 Execution Steps
To run this configuration, you must have an existing VPC and Subnet meeting the filter criteria.

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Review Data Source fetching**:
   ```bash
   terraform plan -var="vpc_id=vpc-0123456789abcdef0"
   ```
3. **Provision the instance**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Only eighteen days left! Next up is a Mini Project: S3 Static Website with CloudFront. 💪*
