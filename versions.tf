terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "hospital-noso-dev-tf-state"
    key            = "connect/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "hospital-noso-dev-tf-lock"
    encrypt        = true
  }
}


# terraform {
#   required_version = ">= 1.5.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#     archive = {
#       source  = "hashicorp/archive"
#       version = "~> 2.4"
#     }
#   }
# }


# terraform {
#   required_version = ">= 1.5.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# required_providers {
#   aws = { source="hashicorp/aws", version="~> 5.0" }
#   archive = { source="hashicorp/archive", version="~> 2.4" }
# }
