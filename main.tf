terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "1.6.0"
    },
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "spacelift" {
}

provider "aws" {
  region = "eu-west-1"
}


resource "spacelift_stack" "aws_fastapi" {
  name         = "AWS Fastapi"
  description  = "Provisions a FastAPI application on AWS"
  repository   = "aws-fastapi"
  project_root = "infra"
  branch       = "master"
  autodeploy   = true
}

module "aws_fastapi_integration" {
  source    = "./modules/aws_integration"
  role_name = "aws-fastapi-spacelift-integration"
  stack_id  = spacelift_stack.aws_fastapi.id
}