variable "instance_id" { type = string }
variable "hours_of_operation_id" { type = string }
variable "name_prefix" { type = string }

variable "queues" {
  type = map(object({
    description = string
  }))
}
