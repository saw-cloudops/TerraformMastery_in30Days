/* # Create a VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = local.common_tags
} */

resource "aws_instance" "dev-instance" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = var.allowed_vm_types[0] 
  #subnet_id     = aws_subnet.dev-subnet.id
  vpc_security_group_ids = [aws_security_group.dev_instance_sg.id] # <-- depends_on ကိုသုံးစရာမလိုတော့ဘူး
  #ကိုယ့်ဘာသာဆောက်တဲ့ VPC သုံးရင်: Security Group ထဲမှာ vpc_id = aws_vpc.dev-vpc.id ဆိုတာကို ထည့်ပေးဖို့ လိုအပ်မယ်နော်။
  
  region = var.region
  associate_public_ip_address = var.associate_public_ip
  count = var.instance_count
  monitoring = var.monitoring_enabled

  tags = local.common_tags
}

resource "aws_security_group" "dev_instance_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = var.ingress_values1[0] #<-- var.ingress_values1[0], var.ingress_values1[1], var.ingress_values1[2]
    to_port     = var.ingress_values1[1] #<-- var.ingress_values1[0], var.ingress_values1[1], var.ingress_values1[2]
    protocol    = var.ingress_values1[2] #<-- var.ingress_values1[0], var.ingress_values1[1], var.ingress_values1[2]
    cidr_blocks = [var.cidr_block[0]] # တကယ်တမ်းက မင်းရဲ့ IP ပဲ ထည့်သင့်တယ်
  }

  ingress {
    from_port   = var.ingress_values2[0] #<-- var.ingress_values2[0], var.ingress_values2[1], var.ingress_values2[2]
    to_port     = var.ingress_values2[1] #<-- var.ingress_values2[0], var.ingress_values2[1], var.ingress_values2[2]
    protocol    = var.ingress_values2[2] #<-- var.ingress_values2[0], var.ingress_values2[1], var.ingress_values2[2]
    cidr_blocks = [var.cidr_block[0]] # တကယ်တမ်းက မင်းရဲ့ IP ပဲ ထည့်သင့်တယ်
  }

  egress {
    from_port   = var.egress_values[0] #<-- var.egress_values[0], var.egress_values[1], var.egress_values[2]
    to_port     = var.egress_values[1] #<-- var.egress_values[0], var.egress_values[1], var.egress_values[2]
    protocol    = var.egress_values[2] #<-- var.egress_values[0], var.egress_values[1], var.egress_values[2]
    cidr_blocks = [var.cidr_block[3]] #<-- var.cidr_block[3] 
  }

  tags = local.common_tags
}

/* #creating s3
resource "aws_s3_bucket" "ash-bucket-50" {
  bucket = local.bucket_name
  region = var.region

  tags = local.common_tags
} */