# #   output "dev_vpc_id" {
# #   value = aws_vpc.dev-vpc.id
# # }

output "aws_instance_id" {
  value = aws_instance.ash_ec2.id
}

# # # output "alb_dns_name" {
# # #   value = aws_lb.ash_alb.dns_name
# # # }

# # # output "asg_name" {
# # #   value = aws_autoscaling_group.ash_asg.name
# # # }

# # # output "launch_template_id" {
# # #   value = aws_launch_template.ash_lt.id
# # # }

# # # output "target_group_arn" {
# # #   value = aws_lb_target_group.ash_tg.arn
# # # }

# # output "ash_ec2_id" {
# #   value = local.all_ec2_ids[*]
# # }

# # output "ash_ec2_public_ip" {
# #   value = aws_instance.ash-ec2[*].public_ip
# # }

# output "formatted_project_name" {
#   value = local.formatted_project_name
# }

# output "sg_rules" {
#   value = local.sg_rules
# }

# output "port_list" {
#   value = local.sg_rules.port
# }

# output "instance_type" {
#   value = local.instance_type
# }

output "password" {
  value     = var.credentials
  sensitive = true

}

output "all_locations" {
  value = local.all_locations
}

output "one_location" {
  value = local.one_location
}

output "original_costs" {
  description = "Original monthly costs (with negatives)"
  value       = var.monthly_costs
}

output "positive_costs" {
  description = "All costs as positive values"
  value       = local.positive_costs
}

output "max_cost" {
  description = "Maximum monthly cost"
  value       = local.max_cost
}

output "total_cost" {
  description = "Total monthly cost"
  value       = local.total_cost
}

output "average_cost" {
  description = "Average monthly cost"
  value       = local.avg_cost
}

output "current_timestamp" {
  value = local.current_timestamp

}

output "config_data" {
  value = local.config_data

}
