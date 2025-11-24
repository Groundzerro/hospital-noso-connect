variable "instance_id" { type = string }
variable "name" { type = string }
variable "time_zone" { type = string }

variable "description" {
  type    = string
  default = null
}

variable "config" {
  type = list(object({
    day        = string
    start_time = object({ hours = number, minutes = number })
    end_time   = object({ hours = number, minutes = number })
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
