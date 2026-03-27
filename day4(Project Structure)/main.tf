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