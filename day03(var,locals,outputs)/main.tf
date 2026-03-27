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
  region  = var.region
  profile = "dev"
}

# Create a VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = var.enviroment
    Name        = "${local.tag_name}-vpc"
  }
}

resource "aws_instance" "dev-instance" {
  ami           = "ami-0be9cb9f67c8dabd6" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  #subnet_id     = aws_subnet.dev-subnet.id
  region = var.region


  tags = {
    Name        = "${local.tag_name}-instance"
    Environment = var.enviroment
  }
}

#creating s3
resource "aws_s3_bucket" "ash-bucket-50" {
  bucket = local.bucket_name
  region = var.region

  tags = {
    Name        = "${local.tag_name}-bucket"
    Environment = var.enviroment
  }
}

