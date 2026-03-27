# 🚀 Day 8: Conditionals, Splat Expressions, and Dynamic Blocks

Welcome to **Day 8** of my **Terraform 30 Days Challenge**! Today's focus is on mastering dynamic configurations using conditional logic and looping constructs specifically designed for nested blocks.

## 🌟 Overview
In advanced Terraform deployments, we often need to deploy different resources depending on the environment (Dev vs. Prod) and keep our code DRY (Don't Repeat Yourself) when dealing with repeated blocks of configuration, such as Security Group rules.

### 📚 Topics Covered
- **Conditional Expressions (`condition ? true_val : false_val`)**: Dynamically selecting values based on logic (e.g., choosing a different EC2 instance size if the environment is "prod").
- **Dynamic Blocks (`dynamic "block_name"`)**: Instead of hardcoding multiple `ingress` or `egress` block rules in a Security Group, we can dynamically generate them from a list/map variable.
- **Splat Expressions (`[*]`)**: A concise way to extract a list of attributes from a list of objects.

## 🛠️ Infrastructure Setup

### What was Created?
1. **Ubuntu EC2 Instance**: 
   - Uses the `aws_ami` data source to dynamically fetch the latest Ubuntu Jammy 22.04 AMI.
   - The `instance_type` is chosen conditionally based on the environment flag:
     ```hcl
     instance_type = var.environment == "dev" ? var.allowed_vm_types[0] : var.allowed_vm_types[1]
     ```
2. **Dynamic AWS Security Group**:
   - Inbound and Outbound rules are created cleanly using `dynamic "ingress"` and `dynamic "egress"` blocks, looping over variables instead of duplicating code.

```hcl
# Example of a Dynamic Ingress Block
dynamic "ingress" {
  for_each = var.ingress_values

  content {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_blocks
  }
}
```

## 🚀 Execution Steps
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Review the conditionally generated plan**:
   ```bash
   terraform plan -var="environment=dev"
   ```
3. **Deploy the configuration**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Onward to Day 9 as I explore Terraform Functions! 💪*
