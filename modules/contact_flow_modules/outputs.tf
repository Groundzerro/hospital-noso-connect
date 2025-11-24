output "module_ids" {
  value = { for k, m in aws_connect_contact_flow_module.module : k => m.contact_flow_module_id }
}

output "module_arns" {
  value = { for k, m in aws_connect_contact_flow_module.module : k => m.arn }
}


# output "module_ids" {
#   value = { for k, m in aws_connect_contact_flow.module : k => m.contact_flow_id }
# }
# output "module_arns" {
#   value = { for k, m in aws_connect_contact_flow.module : k => m.arn }
# }
