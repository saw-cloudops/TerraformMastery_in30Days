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
  region = "ap-southeast-1"
  profile = "dev"
}

/* Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
*/

#creating s3
resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "ash-test-bucket30"

  tags = {
    Name        = "my_first_bucket"
    Environment = "Dev"
  }
}
