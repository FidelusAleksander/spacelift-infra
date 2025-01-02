resource "spacelift_stack" "aws_fastapi" {
  name         = "AWS Fastapi"
  description  = "Provisions a FastAPI application on AWS"
  repository   = "aws-fastapi"
  project_root = "infra"
  branch       = "master"
  autodeploy   = true
  space_id     = spacelift_space.workloads-dev.id
}

resource "spacelift_stack" "storage" {
  name                    = "Storage"
  description             = "Provisions Storage Resources"
  repository              = "spacelift-aws-demo"
  project_root            = "storage"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.workloads-dev.id
  terraform_workflow_tool = "OPEN_TOFU"
  terraform_version       = "1.6.0-alpha4"
}

resource "spacelift_stack" "networking" {
  name         = "Networking"
  description  = "Provisions Networking Resources"
  repository   = "spacelift-aws-demo"
  project_root = "networking"
  branch       = "master"
  autodeploy   = true
  space_id     = spacelift_space.workloads-dev.id
  labels       = ["infracost"]
}

resource "spacelift_environment_variable" "infracost_api_key" {
  stack_id   = spacelift_stack.networking.id
  name       = "INFRACOST_API_KEY"
  value      = var.infracost_api_key
  write_only = true
}

resource "spacelift_stack_dependency" "aws_fastapi_networking" {
  stack_id            = spacelift_stack.aws_fastapi.id
  depends_on_stack_id = spacelift_stack.networking.id
}

resource "spacelift_stack_dependency_reference" "aws_fastapi_networking_vpc_id" {
  stack_dependency_id = spacelift_stack_dependency.aws_fastapi_networking.id
  output_name         = "vpc_id"
  input_name          = "TF_VAR_vpc_id"
}

resource "spacelift_stack_dependency" "aws_fastapi_storage" {
  stack_id            = spacelift_stack.aws_fastapi.id
  depends_on_stack_id = spacelift_stack.storage.id
}

resource "spacelift_stack_dependency_reference" "aws_fastapi_networking_s3_bucket_name" {
  stack_dependency_id = spacelift_stack_dependency.aws_fastapi_storage.id
  output_name         = "s3_bucket_name"
  input_name          = "TF_VAR_s3_bucket_name"
}