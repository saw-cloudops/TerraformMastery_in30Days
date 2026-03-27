variable "environment" {
  default = "dev"
  type    = string
}
# export TF_VAR_environment=stage <-- in terminal to change the value of environment variable

variable "bucket_name1" {
  default = ["ash-third-bucket", "ash-fourth-bucket"] #<-- var.bucket_name[0], var.bucket_name[1]
  type    = list(string)
}

variable "bucket_name2" { #<-- it is also called map(string)type with key=value pair
  default = {
    logs    = "aungsaw-prod-logs"
    assets  = "aungsaw-prod-assets"
    backups = "aungsaw-prod-backups"
  }
}

variable "counter" {
  default = 2
  type    = number
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "availability_zones" {
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  type    = list(string)
}

variable "instance_count" {
  default     = [2, 2, 4]
  type        = list(number)
  description = "Count of EC2 instances to create"
}

variable "allowed_vm_types" {
  default     = ["t2.micro", "t3.micro", "t3a.micro"]
  type        = list(string)
  description = "List of allowed EC2 instance types"

}

variable "aws_instance_ami" {
  default     = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  type        = string
  description = "AMI ID for the EC2 instances"

}

variable "monitoring_enabled" {
  default     = false
  type        = bool
  description = "Enable detailed monitoring for EC2 instances"
}

variable "associate_public_ip" {
  default     = true
  type        = bool
  description = "Whether to associate a public IP address with the EC2 instances"
}

variable "cidr_block" {
  default     = ["10.0.0.0/16", "192.168.0.0/24", "172.16.0.0/24", "0.0.0.0/0"] #<--var.cidr_block[0], var.cidr_block[1], var.cidr_block[2]
  type        = list(string)
  description = "List of CIDR blocks for VPC"
}

variable "ingress_values" {
  description = "ingress_values_for_instances"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTP" },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTPS" },
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "SSH" }
  ]
}

variable "egress_values" {
  description = "egress_values_for_instances"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = number
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    { from_port = 0, to_port = 0, protocol = -1, cidr_blocks = ["0.0.0.0/0"], description = "All traffic" }
  ]
}


# variable "ingress_values1" {
#   type        = tuple([number, number, string, string]) #<-- tuple([from_port, to_port, protocol])
#   default     = [80, 80, "tcp", "HTTP"]
#   description = "Tuple for ingress rule values: [from_port, to_port, protocol]"
# }

# variable "ingress_values2" {
#   type        = tuple([number, number, string]) #<-- tuple([from_port, to_port, protocol])
#   default     = [443, 443, "tcp"]
#   description = "Tuple for ingress rule values: [from_port, to_port, protocol]"

# }

# variable "ingress_values3" {
#   type        = tuple([number, number, string]) #<-- tuple([from_port, to_port, protocol])
#   default     = [22, 22, "tcp"]
#   description = "Tuple for ingress rule values: [from_port, to_port, protocol]"

# }

# variable "egress_values" {
#   type        = tuple([number, number, string, string]) #<-- tuple([from_port, to_port, protocol])
#   default     = [0, 0, "tcp", "-1"]
#   description = "Tuple for egress rule values: [from_port, to_port, protocol]"

# }

/*
variable "config" {
  type = object({
    instance_type = string
    monitoring    = bool
    count         = number
  })
  default = {
    instance_type = "t2.micro"
    monitoring    = false
    count = 1
  }
  description = "Object variable for EC2 instance configuration"
  
} */
