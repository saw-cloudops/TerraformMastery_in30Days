# resource "aws_vpc" "dev_vpc" {
#   # CIDR Block ကို လက်နဲ့ မပေးတော့ဘူး
#   ipv4_ipam_pool_id    = aws_vpc_ipam_pool.dev_pool.id
#   ipv4_netmask_length  = 24 # "ငါ့ကို /24 range တစ်ခု အလွတ်ပေးပါ" လို့ ခိုင်းတာ
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   tags = {
#     Name = "dev-vpc-from-ipam"
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "ash_sg" {
  name        = "ash-ec2-sg"
  description = "Security group for ash-ec2"

  dynamic "ingress" {
    for_each = var.ingress_values

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.egress_values
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  tags = merge(
    local.common_tags, { Name = "ash-ec2-sg" }
  )
}

resource "aws_instance" "ash-ec2" {
  ami   = data.aws_ami.ubuntu.id
  count = var.instance_count[0]
  #instance_type = var.allowed_vm_types[0]
  instance_type = var.environment == "dev" ? var.allowed_vm_types[0] : var.allowed_vm_types[1]
  #above_line is conditional_expression

  vpc_security_group_ids      = [aws_security_group.ash_sg.id] #main_connection_of_sg&ec2
  associate_public_ip_address = var.associate_public_ip

  tags = merge(
    local.common_tags, { Name = "ash-ec2" }
  )
}
