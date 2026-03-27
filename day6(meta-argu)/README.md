# 🚀 Day 6: Terraform Meta-Arguments (`count`, `for_each`, `depends_on`)

Welcome to **Day 6** of my **Terraform 30 Days Challenge**! Today is focused on controlling how Terraform builds resources using special constructs known as **Meta-Arguments**.

## 🌟 Overview
Instead of copying and pasting the same resource block to create multiple instances, Terraform provides elegant tools to scale resources mathematically or iterate dynamically over maps and sets.

### 📚 Topics Covered
- **`count`**: An integer value that creates that many identical copies of a resource. Inside the resource block, `count.index` provides the current iteration index (used with `list` variables).
- **`for_each`**: Accepts a `map` or a `set of strings` to create one resource instance per element. This is safer than `count` when adding or removing items from the middle of a collection, as `each.key` and `each.value` are tied to the specific resource.
- **`depends_on`**: Explicitly defines implicit dependencies between resources. This is used when Terraform cannot automatically infer the deployment order.

## 🛠️ Infrastructure Setup

### What was Created?
1. **Multiple S3 Buckets using `count`**: Retrieves names from a list of strings (`["ash-third-bucket", "ash-fourth-bucket"]`).
2. **Multiple S3 Buckets using `for_each`**: Iterates over a map (`logs`, `assets`, `backups`) setting predictable state mappings.
3. **Explicit Dependencies**: The `for_each` buckets are configured with `depends_on` the `count` buckets, ensuring the first batch deploys before the second.

```hcl
# main.tf snippet showing for_each & depends_on
resource "aws_s3_bucket" "ash-second-bucket" {
  for_each   = var.bucket_name2
  bucket     = each.value             
  region     = var.region
  
  depends_on = [ aws_s3_bucket.ash-first-bucket ]
}
```

## 🚀 Execution Steps
1. **Init**: Prepare the working directory.
   ```bash
   terraform init
   ```
2. **Plan**: Observe how Terraform plans to build the resources via indexes `[0], [1]` vs keys `["logs"], ["assets"]`.
   ```bash
   terraform plan
   ```
3. **Apply**: Provision the buckets to AWS.
   ```bash
   terraform apply -auto-approve
   ```

## 🔗 Connect with Me
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*Halfway to Day 12! Let's keep automating! 💪*
