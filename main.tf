terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }
  cloud {
    organization = "dng_org"

    workspaces {
      name = "terraform_executions"
    }
  }
}
