terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.19"
    }
  }
}

provider "spacelift" {
}
