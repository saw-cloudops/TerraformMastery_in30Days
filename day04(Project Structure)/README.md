# 🚀 Day 4: Standard Project Structure

Welcome to **Day 4** of my **Terraform 30 Days Challenge**! Today is all about code organization and standardizing a professional architecture for Terraform projects.

## 🌟 Overview
As infrastructure grows, placing everything inside a single `main.tf` file becomes cluttered and difficult to manage. Today, I broke down the single-file setup from Day 3 into a clean, modular **Standard Project Structure**.

### 📚 Topics Covered
- Organizing Terraform `.tf` files logically.
- Separating configuration contexts for readability and maintainability.
- The standard breakdown:
  - `main.tf`: Core resource definitions (VPC, EC2, S3).
  - `providers.tf`: Cloud provider configurations (AWS).
  - `backends.tf`: Configuration for remote state tracking (S3).
  - `variable.tf`: Input variable declarations.
  - `locals.tf`: Evaluated local expressions.
  - `output.tf`: Exported values.

## 🛠️ Infrastructure Setup

### What was Created?
The physical resources remain the same as Day 3, but the way they are defined has completely changed. 
1. **AWS EC2 Instance** (`t2.micro`)
2. **AWS VPC**
3. **AWS S3 Bucket**

By splitting the files, the project is now ready to scale cleanly.

## 🚀 Execution Steps
The execution workflow remains identical, but the internal handling is vastly improved.

1. **Initialize the workspace**:
   ```bash
   terraform init
   ```
2. **View the organized plan**:
   ```bash
   terraform plan
   ```
3. **Provision the stack**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Follow my journey as I master Terraform! 💪*
