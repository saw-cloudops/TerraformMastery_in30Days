# 🚀 Day 9: Mastering Terraform Built-in Functions (Part 1) & Locals

Welcome to **Day 9** of my **Terraform 30 Days Challenge**! Today was all about **Terraform Built-in Functions** and **Locals**. Hardcoding values limits scalability; built-in functions allow us to transform, query, and combine data dynamically as the project grows.

## 🌟 Overview
The goal for today was to harness Terraform's powerful built-in functions to dynamically format strings, manipulate collections, and look up values safely.

### 📚 Topics Covered
- **String Manipulation**:
  - `lower()` & `upper()`: Changing string casing natively (e.g., standardizing tagging schemas).
  - `replace()`: Sanitizing strings. For instance, replacing spaces with dashes to create clean, URL-safe S3 bucket names.
  - `split()`: Breaking comma-separated values (CSVs) into lists.
- **Collection & Data Structure Mapping**:
  - `lookup()`: Dynamically selecting values based on a given key safely with a default fallback.
  - `merge()`: Combining multiple maps into a single cohesive map (heavily used for unifying standard tags with resource-specific tags).
- **Loop Transformations**: Leveraged `for` expressions in `locals` to iterate over strings and return an array of structured objects.

## 🛠️ Infrastructure Setup

### What was Created?
- **Dynamic S3 Bucket**: Created an `aws_s3_bucket` dynamically named using `replace` and `lower` standards.
- **Robust Tags**: Combined common project tags with specific resource tags using the `merge()` function.

```hcl
# Example of using Merge and Upper functions for Tagging
resource "aws_s3_bucket" "ash_bucket" {
  bucket = local.formatted_project_name

  tags = merge(local.tags, { Name = upper("aungsawhein") })
}
```

## 🚀 Execution Steps
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Review the calculated functions and transformations**:
   ```bash
   terraform plan
   ```
3. **Provision**:
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Stay tuned for Day 10 where I explore Advanced Functions and Validations! 💪*
