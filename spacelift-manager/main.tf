terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.24"
    }
  }
}

provider "spacelift" {
}

provider "aws" {
  region = "eu-west-1"
}
