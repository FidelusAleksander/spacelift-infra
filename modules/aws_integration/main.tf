terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}
