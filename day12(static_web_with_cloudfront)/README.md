# 🚀 Day 12: Static Website Hosting with CloudFront (Mini Project)

Welcome to **Day 12** of my **Terraform 30 Days Challenge**! Today marks our first major practical milestone: deploying a blazingly fast, highly secure Static Website on AWS using S3 and CloudFront CDN.

## 🌟 Architecture Overview
Instead of exposing an S3 bucket directly to the internet (which is bad for performance and security), this architecture implements enterprise best practices.

```text
Internet 🌍 → AWS CloudFront (CDN) ⚡ → S3 Bucket (Private Origin) 🪣
```

### 📚 Topics Covered
- **Private S3 Buckets**: Creating an S3 bucket with completely blocked public access to secure the raw assets.
- **CloudFront Content Delivery Network**: Distributing the website globally with low latency.
- **Origin Access Control (OAC)**: Modern AWS security standard verifying that the S3 bucket only accepts requests exclusively from the CloudFront Distribution.
- **Dynamic File Uploading**: Using Terraform's `for_each`, `fileset()`, and `filemd5()` to automatically upload and update all HTML/CSS/JS files from a local directory into S3 while injecting the correct MIME `content_type` headers dynamically.

## 🛠️ Infrastructure Setup

### What was Configured?
1. **AWS S3 Bucket**: Configured specifically for hosting files, but with all public ACLs firmly blocked.
2. **Bucket Policy**: An IAM JSON policy granting `s3:GetObject` absolutely only if the `AWS:SourceArn` matches the CloudFront Distribution ARN.
3. **AWS CloudFront Distribution**: Forwards HTTPS traffic automatically, caches standard assets, and points directly to the private S3 bucket.

## 🚀 Execution Steps
1. **Initialize the workspace**:
   ```bash
   terraform init
   ```
2. **Plan the deployment**:
   ```bash
   terraform plan
   ```
3. **Provision the stack**:
   ```bash
   terraform apply -auto-approve
   ```
4. **Access the Website**:
   Terraform will output the `cloudfront_domain_name`. Open it in your browser to see the live site!

## 🔗 Connect with Me
I am documenting my entire 30-day journey to master Terraform and AWS!
- **LinkedIn:** [Aung Saw Hein](https://www.linkedin.com/in/aung-saw-hein-47a616225/)
- **GitHub:** [saw-cloudops](https://github.com/saw-cloudops)

*This wraps up Day 12! Stay tuned as the complexity increases! 💪*