output "queue_ids" {
  value = { for k, q in aws_connect_queue.this : k => q.queue_id }
}

output "queue_arns" {
  value = { for k, q in aws_connect_queue.this : k => q.arn }
}


# output "queue_arns" {
#   value = { for k, q in aws_connect_queue.this : k => q.queue_arn }
# }
