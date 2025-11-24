variable "instance_id" { type = string }
variable "name_prefix" { type = string }

variable "modules" {
  type = map(object({
    description = string
    file_path   = string
  }))
}
