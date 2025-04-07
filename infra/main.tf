# terraform config
terraform {
  backend "s3" {
      bucket = "floriantz-terraform-states"
      key    = "websites-platform-take-home"
      region = "eu-west-3"
      use_lockfile = true
    }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# aws config
provider "aws" {
  region = "eu-west-3"
  profile = "default"
}

