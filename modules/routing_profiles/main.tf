resource "aws_connect_routing_profile" "this" {
  for_each = var.routing_profiles

  instance_id = var.instance_id
  name        = "${var.name_prefix}-${each.key}"
  description = each.value.description

  default_outbound_queue_id = var.queue_ids[each.value.default_outbound_queue]

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }
  dynamic "queue_configs" {
    for_each = each.value.queue_priorities
    content {
      queue_id = var.queue_ids[queue_configs.value.queue_name]
      channel  = "VOICE"
      priority = queue_configs.value.priority
      delay    = queue_configs.value.delay
    }
  }
}
