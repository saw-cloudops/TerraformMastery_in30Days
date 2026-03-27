# 🚀 Day 10: Advanced Functions & Variable Validations (Part 2)

Welcome to **Day 10** of my **Terraform 30 Days Challenge**! Today's session focused on expanding knowledge of Terraform functions and implementing robust variable validation techniques to ensure infrastructure integrity.

## 🌟 Overview
Following Day 9, today we explored advanced mathematical calculations, advanced collection processing, and most importantly, natively validating variable inputs to fail fast before AWS APIs are even called.

### 📚 Topics Covered
- **Robust Variable Validation**:
  - `length()`: Ensures the instance type string is within a valid range.
  - `regex()` & `can()`: Validates that the instance type follows a specific pattern (e.g., starting with `t2` or `t3`).
- **Advanced Collection Functions**:
  - `concat()`: Merges multiple lists of locations.
  - `toset()`: Removes duplicates from lists to ensure unique resource placement.
  - `for` expressions: Dynamically transforming data.
- **Mathematical & Built-in Functions**:
  - `abs()`, `max()`, `sum()`.
  - `timestamp()`: Captures the exact time of the infrastructure plan/apply for audit trails.
- **Dynamic File Handling & JSON Parsing**:
  - `fileexists()`: Safely checks for the existence of external configuration files.
  - `file()` & `jsondecode()`: Reads and parses external JSON configurations into Terraform locals.

## 🛠️ Infrastructure Setup

### What was Created?
Instead of creating dozens of resources, the focus was firmly on the `locals.tf`, `variable.tf`, and `output.tf` structure to prove the functional logic calculations and strict constraints using validation blocks. An EC2 instance was instantiated functionally.

```hcl
# Instance created utilizing advanced validated variables
resource "aws_instance" "ash_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  tags = {
    Name = "ash-ec2"
  }
}
```

## 🚀 Execution Steps
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Review Outputs and Variable validations**:
   ```bash
   terraform plan
   ```
   *Try modifying variable inputs in `terraform.tfvars` or CLI to deliberately trigger custom validation errors!*
3. **Provision**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Next up, Day 11: Data Sources! 💪*
