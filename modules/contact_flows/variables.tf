variable "instance_id" { type = string }
variable "name_prefix" { type = string }

variable "flows" {
  type = map(object({
    description = string
    file_path   = string
  }))
}

# passed for future templating; not required by resource directly
variable "queue_ids" {
  type    = map(string)
  default = {}
}

variable "module_arns" {
  type    = map(string)
  default = {}
}
