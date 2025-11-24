output "routing_profile_ids" {
  value = { for k, rp in aws_connect_routing_profile.this : k => rp.routing_profile_id }
}
