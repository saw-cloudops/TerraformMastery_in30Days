locals {
  common_tags = {
    Project = "TF_30D_Challenge"
    #Name        = "cloud_engineer_aungsaw"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Aung Saw Hein"
  }
}
