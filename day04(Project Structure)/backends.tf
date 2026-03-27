terraform {
  # 1. Backend configuration
  backend "s3" {
    bucket       = "aung-saw-bucket-30"
    key          = "dev/terraform.tfstate"
    region       = "ap-southeast-1"
    profile      = "dev"
    encrypt      = true
    use_lockfile = true
  } 
}