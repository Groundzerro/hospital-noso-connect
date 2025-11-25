variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "name_prefix" {
  type    = string
  default = "hospital-noso-dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}

