provider "aws" {
  region = var.aws_region

  profile = (
    can(var.aws_profile) && var.aws_profile != null && var.aws_profile != ""
  ) ? var.aws_profile : null
}


# provider "aws" {
#   region  = var.aws_region
#   profile = var.aws_profile
# }
