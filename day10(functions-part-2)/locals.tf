# locals {
#   formatted_project_name = lower(replace(var.formatted_project_name, " ", "-"))
# }

locals {
  tags = {
    Environment = var.environment
    Project     = "dev-project"
    ManagedBy   = "Terraform"
  }
  # Split comma-separated ports into list
  #port_list = split(",", var.allowed_ports)

  # Create security group rules data structure
  sg_rules = [for port in var.allowed_ports : {
    name        = "port-${port.from_port}-${port.to_port}"
    port        = [port.from_port]
    description = "Allow traffic on port [${port.from_port}]"
  }]
  #instance_type = lookup(var.instance_type, var.environment, "t2.nano")
  all_locations = concat(var.all_locations, var.default_location)
  one_location  = toset(local.all_locations)
}


#Functions: abs(), max(), for expression
locals {
  # Convert negative values (credits) to positive
  positive_costs = [for cost in var.monthly_costs : abs(cost)]

  # Find maximum cost
  max_cost = max(local.positive_costs...)

  # Calculate total
  total_cost = sum(local.positive_costs)

  # Calculate average
  avg_cost = local.total_cost / length(local.positive_costs)

  current_timestamp = timestamp()
}

#file_handling
locals {
  # Read and parse JSON configuration file
  config_file_exists = fileexists("./config.json")
  config_data        = local.config_file_exists ? jsondecode(file("./config.json")) : {}
}
