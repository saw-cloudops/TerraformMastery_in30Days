locals {
  bucket_name = "${var.bucket_name}-bucket-${var.environment}"
}

locals {
  common_tags = {
    Project     = "TF_30D_Challenge"
    Name        = "aungsawhein"
    Environment = var.environment
    ManagedBy    = "Terraform"
  }
}
