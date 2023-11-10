terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.6.0"
    }
  }
}

provider "spacelift" {
}

resource "spacelift_stack" "aws_fastapi" {
  name              = "AWS Fastapi"
  description       = "Provisions a FastAPI application on AWS"
  repository        = "aws-fastapi"
  project_root      = "infra"
  branch            = "master"
  autodeploy        = true
}
