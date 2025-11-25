variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type    = string
  default = "null"
}

variable "instance_id" {
  description = "Existing Amazon Connect Instance ID"
  type        = string
}

variable "project_name" { type = string }
variable "environment" { type = string }

variable "time_zone" {
  type    = string
  default = "America/Chicago"
}

variable "hours_of_operation" {
  type = object({
    name = string
    config = list(object({
      day        = string # MONDAY..SUNDAY
      start_time = object({ hours = number, minutes = number })
      end_time   = object({ hours = number, minutes = number })
    }))
  })
}

variable "queues" {
  description = "Department queues"
  type = map(object({
    description = string
  }))
}

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

variable "flow_modules" {
  type = map(object({
    description = string
    file_path   = string
  }))
}

variable "contact_flows" {
  type = map(object({
    description = string
    file_path   = string
  }))
}
