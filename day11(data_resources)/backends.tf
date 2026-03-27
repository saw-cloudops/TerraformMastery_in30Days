terraform {
  # 1. Backend configuration
  backend "s3" {
    bucket       = "aung-saw-bucket"
    key          = "frontend/terraform.tfstate"
    region       = "ap-southeast-1"
    #profile      = "dev"
    encrypt      = true
    use_lockfile = true
  } 
}