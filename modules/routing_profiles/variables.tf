variable "instance_id" { type = string }
variable "name_prefix" { type = string }
variable "queue_ids" { type = map(string) }

variable "routing_profiles" {
  type = map(object({
    description            = string
    default_outbound_queue = string
    queue_priorities = list(object({
      queue_name = string
      priority   = number
      delay      = number
    }))
  }))
}
