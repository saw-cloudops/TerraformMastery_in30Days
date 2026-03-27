# 🚀 Day 5: Advanced Variable Type Constraints

Welcome to **Day 5** of my **Terraform 30 Days Challenge**! Today, we dive deeper into making our Terraform configurations robust and predictable using **Type Constraints**.

## 🌟 Overview
While variables are great for passing dynamic values, leaving their type unrestricted can lead to configuration errors. By explicitly defining the `<type>` of our input variables, Terraform can enforce data validation during the plan and apply phases.

### 📚 Topics Covered
- **Primitive Types**: `string`, `number`, `bool`
- **Complex Types (Collections)**:
  - `list(type)`: Ordered sequences (e.g., allowed instance types like `["t2.micro", "t3.micro"]`).
  - `map(type)`: Key-value pairs.
- **Structural Types**:
  - `tuple([type1, type2, ...])`: A sequence of distinct types, heavily used in this module to define Security Group rules (e.g., `[22, 22, "tcp"]`).
  - `object({ ... })`: Complex structures.

## 🛠️ Infrastructure Setup

### What was Created?
The configuration leverages these type constraints to build secure and flexible resources:
1. **AWS EC2 Instance**: Instance type chosen from a `list(string)`, monitoring enabled via `bool`, and counts defined by a `number`.
2. **AWS Security Group**: Inbound and outbound rules dynamically parsed from `tuple()` constraints, ensuring ports are numbers and protocols are strings.

```hcl
# Example from var.tf defining a strict Tuple for ingress.
variable "ingress_values1" {
  type        = tuple([number, number, string]) 
  default     = [22, 22, "tcp"]
  description = "Tuple for ingress rule values: [from_port, to_port, protocol]"
}
```

## 🚀 Execution Steps
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Plan infrastructure**:
   ```bash
   terraform plan
   ```
3. **Provision the environment**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Ready for more? Let's move on to Day 6 where we explore Meta-Arguments! 💪*
