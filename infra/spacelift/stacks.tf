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
      enable_infracost   = true
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
      enable_infracost   = true
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

  stack_name   = each.value.stack_name
  project_root = each.value.project_root
  description  = each.value.description
  repository   = each.value.repository
  space_id     = each.value.space_id

  autodeploy              = try(each.value.autodeploy, null)
  labels                  = try(each.value.labels, [])
  aws_integration_id      = try(each.value.aws_integration_id, null)
  terraform_workflow_tool = try(each.value.terraform_workflow_tool, null)
  terraform_version       = try(each.value.terraform_version, null)

  infracost = {
    enabled = try(each.value.enable_infracost, null)
    api_key = var.infracost_api_key
  }
}


# TODO: Create a module for stack dependencies

resource "spacelift_stack_dependency" "aws_fastapi_networking" {
  stack_id            = module.stacks["spacelift_demo_aws_fastapi"].stack_id
  depends_on_stack_id = module.stacks["spacelift_demo_networking"].stack_id
}

resource "spacelift_stack_dependency_reference" "aws_fastapi_networking_vpc_id" {
  stack_dependency_id = spacelift_stack_dependency.aws_fastapi_networking.id
  output_name         = "vpc_id"
  input_name          = "TF_VAR_vpc_id"
}

resource "spacelift_stack_dependency" "aws_fastapi_storage" {
  stack_id            = module.stacks["spacelift_demo_aws_fastapi"].stack_id
  depends_on_stack_id = module.stacks["spacelift_demo_storage"].stack_id
}

resource "spacelift_stack_dependency_reference" "aws_fastapi_networking_s3_bucket_name" {
  stack_dependency_id = spacelift_stack_dependency.aws_fastapi_storage.id
  output_name         = "s3_bucket_name"
  input_name          = "TF_VAR_s3_bucket_name"
}
