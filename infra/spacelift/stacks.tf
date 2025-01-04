## Spacelift Demo
resource "spacelift_stack" "spacelift_demo_core" {
  name                    = "Core - Spacelift Demo"
  description             = "Provisions Core Infrastructure for Spacelift Demo project"
  repository              = "spacelift-infra"
  project_root            = "infra/workloads/spacelift-demo/core"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.workloads-dev.id
  terraform_workflow_tool = local.default_terraform_workflow_tool
  terraform_version       = local.default_terraform_version
  labels                  = ["spacelift-demo"]
}


resource "spacelift_stack" "aws_fastapi" {
  name                    = "AWS Fastapi"
  description             = "Provisions a FastAPI application on AWS"
  repository              = "aws-fastapi"
  project_root            = "infra"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.workloads-dev.id
  terraform_workflow_tool = local.default_terraform_workflow_tool
  terraform_version       = local.default_terraform_version
  labels                  = ["spacelift-demo"]
}


resource "spacelift_stack" "storage" {
  name                    = "Storage"
  description             = "Provisions Storage Resources"
  repository              = "spacelift-infra"
  project_root            = "infra/workloads/spacelift-demo/storage"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.workloads-dev.id
  terraform_workflow_tool = local.default_terraform_workflow_tool
  terraform_version       = local.default_terraform_version
  labels                  = ["spacelift-demo"]
}

resource "spacelift_stack" "networking" {
  name                    = "Networking"
  description             = "Provisions Networking Resources"
  repository              = "spacelift-infra"
  project_root            = "infra/workloads/spacelift-demo/networking"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.workloads-dev.id
  labels                  = ["infracost", "spacelift-demo"]
  terraform_workflow_tool = local.default_terraform_workflow_tool
  terraform_version       = local.default_terraform_version
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


## Shared Services

resource "spacelift_stack" "shared_services_core" {
  name                    = "Core - Shared Services"
  description             = "Provisions Core Infrastructure for Shared Services account"
  repository              = "spacelift-infra"
  project_root            = "infra/shared-services/core"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.infrastructure.id
  terraform_workflow_tool = local.default_terraform_workflow_tool
  terraform_version       = local.default_terraform_version
  labels                  = ["shared-services"]
}

resource "spacelift_stack" "shared_services_github_runners" {
  name                    = "GitHub Self Hosted Runners"
  description             = "Provisions AWS Infrastructure for GitHub Self Hosted Runners"
  repository              = "spacelift-infra"
  project_root            = "infra/shared-services/github-runners"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.infrastructure.id
  terraform_workflow_tool = local.default_terraform_workflow_tool
  terraform_version       = local.default_terraform_version
  labels                  = ["shared-services", "infracost"]
}

## Infracost

resource "spacelift_environment_variable" "infracost_api_key" {
  for_each = {
    networking                     = spacelift_stack.networking.id
    shared_services_github_runners = spacelift_stack.shared_services_github_runners.id
  }
  stack_id   = each.value
  name       = "INFRACOST_API_KEY"
  value      = var.infracost_api_key
  write_only = true
}
