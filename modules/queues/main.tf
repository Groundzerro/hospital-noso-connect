resource "aws_connect_queue" "this" {
  for_each = var.queues

  instance_id           = var.instance_id
  name                  = "${var.name_prefix}-${each.key}"
  description           = each.value.description
  hours_of_operation_id = var.hours_of_operation_id
}
