output "hours_of_operation_id" {
  value = module.hours.hours_id
}

output "queue_ids" {
  value = module.queues.queue_ids
}

output "routing_profile_ids" {
  value = module.routing_profiles.routing_profile_ids
}

output "module_arns" {
  value = module.flow_modules.module_arns
}

output "flow_arns" {
  value = module.contact_flows.flow_arns
}
