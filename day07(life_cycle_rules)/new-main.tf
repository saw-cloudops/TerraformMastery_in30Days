# ၁. VPC ဆောက်မယ်
resource "aws_vpc" "ash_vpc" {
  cidr_block           = var.cidr_block[0] # "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, { Name = "ash-vpc" })
}

# ၂. Internet Gateway ဆောက်မယ် (Internet ထွက်ဖို့)
resource "aws_internet_gateway" "ash_igw" {
  vpc_id = aws_vpc.ash_vpc.id
  tags   = merge(local.common_tags, { Name = "ash-igw" })
}

# ၃. Public Subnets (၂) ခု ဆောက်မယ် (ALB အတွက်)
resource "aws_subnet" "public_subnets" {
  count                   = var.instance_count[0]
  vpc_id                  = aws_vpc.ash_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block[0], 8, count.index) # "10.0.0.0/24", "10.0.1.0/24" လို့ ခွဲထုတ်ပေးမယ်
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, { Name = "ash-public-subnet-${count.index}" })
}

# ၄. Route Table ဆောက်မယ်
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ash_vpc.id

  route {
    cidr_block = var.cidr_block[3]
    gateway_id = aws_internet_gateway.ash_igw.id
  }

  tags = merge(local.common_tags, { Name = "ash-public-rt" })
}

# ၅. Subnets နဲ့ Route Table ကို ချိတ်မယ်
resource "aws_route_table_association" "public_assoc" {
  count          = var.instance_count[0]
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# ALB အတွက် Security Group (Internet ကနေ Port 80 ကို ခွင့်ပြုမယ်)
resource "aws_security_group" "alb_sg" {
  name_prefix = "ash-alb-sg-"
  vpc_id      = aws_vpc.ash_vpc.id

  ingress {

    from_port   = var.ingress_values1[0]
    to_port     = var.ingress_values1[1]
    protocol    = var.ingress_values1[2]
    cidr_blocks = [var.cidr_block[3]]
  }
  egress {
    from_port   = var.egress_values[0]
    to_port     = var.egress_values[1]
    protocol    = var.egress_values[3]
    cidr_blocks = [var.cidr_block[3]]
  }
}

# EC2 အတွက် Security Group (ALB ဆီကလာတဲ့ Traffic ကိုပဲ လက်ခံမယ်)
resource "aws_security_group" "asg_sg" {
  name_prefix = "ash-asg-sg-"
  vpc_id      = aws_vpc.ash_vpc.id

  ingress {
    from_port       = var.ingress_values1[0]
    to_port         = var.ingress_values1[1]
    protocol        = var.ingress_values1[2]
    security_groups = [aws_security_group.alb_sg.id]
    cidr_blocks     = [var.cidr_block[3]]
  }
  ingress {
    from_port       = var.ingress_values3[0]
    to_port         = var.ingress_values3[1]
    protocol        = var.ingress_values3[2]
    security_groups = [aws_security_group.alb_sg.id]
    cidr_blocks     = [var.cidr_block[3]]
  }

  egress {
    from_port   = var.egress_values[0]
    to_port     = var.egress_values[1]
    protocol    = var.egress_values[3]
    cidr_blocks = [var.cidr_block[3]]
  }
}

# aws_instance နေရာမှာ ဒါကို အစားထိုးရမယ်။
resource "aws_launch_template" "ash_lt" {
  name_prefix   = "ash-launch-template-"
  image_id      = var.aws_instance_ami
  instance_type = var.allowed_vm_types[0]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Hello from Terraform 30Days Challenge By Aung Saw Hein on $HOSTNAME!</h1>" > /usr/share/nginx/html/index.html
  EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.common_tags
  }
}

/* resource "aws_instance" "ash-ec2" {
  ami           = var.aws_instance_ami
  instance_type = var.allowed_vm_types[0] #<-- var.allowed_vm_types[0], var.allowed_vm_types[1], var.allowed_vm_types[2]
  # instance_type = ami-0be9cb9f67c8dabd6 #(amazon linux ami)
  region = var.region
  availability_zone = var.availability_zones[0] #<-- var.availability_zones[0], var.availability_zones[1], var.availability_zones[2]

  tags = local.common_tags
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
  }
} */

# ALB ဆောက်မယ်
resource "aws_lb" "ash_alb" {
  name               = "ash-prod-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id] # မင်းရဲ့ Subnet ID တွေ ထည့်ပေးပါ
}

# Target Group ဆောက်မယ်
resource "aws_lb_target_group" "ash_tg" {
  name        = "ash-target-group"
  port        = var.ingress_values1[0]
  protocol    = var.ingress_values1[3]
  vpc_id      = aws_vpc.ash_vpc.id # မင်းရဲ့ VPC ID ထည့်ပေးပါ
  target_type = "instance"

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# Listener ဆောက်မယ် (Port 80 ကလာရင် TG ကို ပို့မယ်)
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ash_alb.arn
  port              = var.ingress_values1[0]
  protocol          = var.ingress_values1[3]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ash_tg.arn
  }
}

#Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "ash_asg" {
  name_prefix         = "ash-asg-"
  min_size            = var.instance_count[0]
  max_size            = var.instance_count[2]
  desired_capacity    = var.instance_count[1]
  vpc_zone_identifier = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id] # Subnets တွေ ထည့်ပါ
  target_group_arns   = [aws_lb_target_group.ash_tg.arn]

  launch_template {
    id      = aws_launch_template.ash_lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 50 # မင်းပြောတဲ့ Health Check 70 seconds ပါ

  lifecycle {
    create_before_destroy = true
  }
}

#Target Tracking Scaling Policy (Recommended)
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "ash-cpu-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.ash_asg.name # မင်းရဲ့ ASG နာမည်
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    # CPU 70% မှာပဲ ထိန်းထားဖို့ ခိုင်းတာပါ
    target_value = 70.0
  }
}
