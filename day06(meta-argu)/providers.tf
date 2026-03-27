terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region #<-- var.region[0], var.region[1], var.region[2]
 #profile = "dev"
}