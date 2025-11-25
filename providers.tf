provider "aws" {
  region = var.aws_region

  # Only use profile if non-empty AND not literally "null"
  profile = (
    can(var.aws_profile) &&
    var.aws_profile != null &&
    var.aws_profile != "" &&
    lower(var.aws_profile) != "null"
  ) ? var.aws_profile : null
}


# provider "aws" {
#   region  = var.aws_region
#   profile = var.aws_profile
# }
