locals {
  formatted_project_name = lower(replace(var.formatted_project_name, " ", "-"))
}

locals {
  tags = {
    Environment = var.environment
    Project     = "dev-project"
    ManagedBy   = "Terraform"
  }
  # Split comma-separated ports into list
  port_list = split(",", var.allowed_ports)

  # Create security group rules data structure
  sg_rules = [for port in local.port_list : {
    name        = "port-${port}"
    port        = port
    description = "Allow traffic on port ${port}"
  }]

  instance_type = lookup(var.instance_type, var.environment, "t2.nano")
}
