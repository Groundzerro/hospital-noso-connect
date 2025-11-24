variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "repo_full_name" {
  type    = string
  default = "Groundzerro/hospital-noso-connect"
}

variable "role_name" {
  type    = string
  default = "github-terraform-hospital-noso"
}

# Start broad, tighten later
variable "attach_admin_policy" {
  type    = bool
  default = true
}
