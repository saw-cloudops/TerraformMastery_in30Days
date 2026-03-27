variable "environment" {
  default = "dev"
  type    = string
}
# export TF_VAR_environment=stage <-- in terminal to change the value of environment variable

variable "bucket_name" {
  default = "aungsaw-bucket-50"
  type    = string
}

variable "region" {
  default = "ap-southeast-1"
  type    = string
}

variable "instance_count" {
  default = 1
  type    = number
  description = "Count of EC2 instances to create"
}

variable "allowed_vm_types" {
  default = ["t2.micro", "t3.micro", "t3a.micro"]
  type    = list(string)
  description = "List of allowed EC2 instance types"
  
}

variable "monitoring_enabled" {
  default = false
  type    = bool
  description = "Enable detailed monitoring for EC2 instances"
}

variable "associate_public_ip" {
  default = true
  type    = bool
  description = "Whether to associate a public IP address with the EC2 instances"
}

 variable "cidr_block" {
  default = ["10.0.0.0/16","192.168.0.0/24","172.16.0.0/24","0.0.0.0/0"] #<--var.cidr_block[0], var.cidr_block[1], var.cidr_block[2]
  type    = list(string)
  description = "List of CIDR blocks for VPC"
} 

variable "ingress_values1" {
  type = tuple([ number, number, string ]) #<-- tuple([from_port, to_port, protocol])
  default = [22, 22, "tcp"]
  description = "Tuple for ingress rule values: [from_port, to_port, protocol]"
}

variable "ingress_values2" {
  type = tuple([ number, number, string ]) #<-- tuple([from_port, to_port, protocol])
  default = [80, 80, "tcp"]
  description = "Tuple for ingress rule values: [from_port, to_port, protocol]"
  
}

variable "egress_values" {
  type = tuple([ number, number, string ]) #<-- tuple([from_port, to_port, protocol])
  default = [0, 0, "tcp"]
  description = "Tuple for egress rule values: [from_port, to_port, protocol]"
  
}

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