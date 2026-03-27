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
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "ap-southeast-1"
  profile = "dev"
}

/* Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
*/

/* #creating s3
resource "aws_s3_bucket" "ash-bucket-40" {
  bucket = "aung-saw-bucket-40"

  tags = {
    Name        = "my_first_bucket"
    Environment = "Dev"
  }
} */

