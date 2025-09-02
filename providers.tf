terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "sandbox"

  default_tags {
    tags = {
      Project = var.project
      Owner   = var.owner
      Env     = var.env
    }
  }
}
