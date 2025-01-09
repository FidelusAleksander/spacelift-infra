locals {
  common_stack_config = {
    repository              = "spacelift-infra"
    autodeploy              = true
    terraform_workflow_tool = "OPEN_TOFU"
    terraform_version       = "1.8.7"
  }

  specific_stack_configs = {
    spacelift_demo_core = {
      stack_name         = "Core - Spacelift Demo"
      description        = "Provisions Core Infrastructure for Spacelift Demo project"
      space_id           = module.workload_spaces.spaces["dev"].id
      project_root       = "infra/workloads/spacelift-demo/core"
      aws_integration_id = spacelift_aws_integration.spacelift_demo.id
      labels             = ["spacelift-demo"]
    },
    spacelift_demo_aws_fastapi = {
      stack_name         = "AWS Fastapi"
      description        = "Provisions a FastAPI application on AWS"
      space_id           = module.workload_spaces.spaces["dev"].id
      aws_integration_id = spacelift_aws_integration.spacelift_demo.id
      repository         = "aws-fastapi"
      project_root       = "infra"
      labels             = ["spacelift-demo"]
    },
    spacelift_demo_storage = {
      stack_name         = "Storage"
      description        = "Provisions Storage Resources"
      space_id           = module.workload_spaces.spaces["dev"].id
      project_root       = "infra/workloads/spacelift-demo/storage"
      aws_integration_id = spacelift_aws_integration.spacelift_demo.id
      labels             = ["spacelift-demo"]
    },
    spacelift_demo_networking = {
      stack_name         = "Networking"
      description        = "Provisions Networking Resources"
      space_id           = module.workload_spaces.spaces["dev"].id
      project_root       = "infra/workloads/spacelift-demo/networking"
      aws_integration_id = spacelift_aws_integration.spacelift_demo.id
      labels             = ["infracost", "spacelift-demo"]
    },
    shared_services_core = {
      stack_name         = "Shared Services Core"
      description        = "Provisions Core Shared Services"
      space_id           = module.root_spaces.spaces["infrastructure"].id
      project_root       = "infra/shared-services/core"
      aws_integration_id = spacelift_aws_integration.shared_services.id
      labels             = ["shared-services"]
    },
    shared_services_github_runners = {
      stack_name         = "GitHub Runners"
      description        = "Provisions GitHub Runners"
      space_id           = module.root_spaces.spaces["infrastructure"].id
      project_root       = "infra/shared-services/github-runners"
      aws_integration_id = spacelift_aws_integration.shared_services.id
      labels             = ["shared-services"]
    }
  }

  stack_configs = {
    for stack_name, stack_config in local.specific_stack_configs : stack_name => merge(local.common_stack_config, stack_config)
  }

}

## Spacelift Demo
module "stacks" {
  for_each = local.stack_configs
  source   = "../modules/spacelift/stack"


  stack_name         = each.value.stack_name
  description        = each.value.description
  repository         = each.value.repository
  project_root       = each.value.project_root
  autodeploy         = each.value.autodeploy
  space_id           = each.value.space_id
  labels             = each.value.labels
  aws_integration_id = each.value.aws_integration_id

  terraform_workflow_tool = each.value.terraform_workflow_tool
  terraform_version       = each.value.terraform_version
}



# resource "spacelift_stack_dependency" "aws_fastapi_networking" {
#   stack_id            = spacelift_stack.aws_fastapi.id
#   depends_on_stack_id = spacelift_stack.networking.id
# }

# resource "spacelift_stack_dependency_reference" "aws_fastapi_networking_vpc_id" {
#   stack_dependency_id = spacelift_stack_dependency.aws_fastapi_networking.id
#   output_name         = "vpc_id"
#   input_name          = "TF_VAR_vpc_id"
# }

# resource "spacelift_stack_dependency" "aws_fastapi_storage" {
#   stack_id            = spacelift_stack.aws_fastapi.id
#   depends_on_stack_id = spacelift_stack.storage.id
# }

# resource "spacelift_stack_dependency_reference" "aws_fastapi_networking_s3_bucket_name" {
#   stack_dependency_id = spacelift_stack_dependency.aws_fastapi_storage.id
#   output_name         = "s3_bucket_name"
#   input_name          = "TF_VAR_s3_bucket_name"
# }


## Shared Services

## Infracost

# resource "spacelift_environment_variable" "infracost_api_key" {
#   for_each = {
#     networking                     = spacelift_stack.networking.id
#     shared_services_github_runners = spacelift_stack.shared_services_github_runners.id
#   }
#   stack_id   = each.value
#   name       = "INFRACOST_API_KEY"
#   value      = var.infracost_api_key
#   write_only = true
# }
