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

module "networking_integration" {
  source    = "./modules/aws_integration"
  role_name = "networking-spacelift-integration"
  stack_id  = spacelift_stack.networking.id
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  ]
  space_id = spacelift_space.workloads-dev.id
}

resource "spacelift_environment_variable" "infracost_api_key" {
  stack_id   = spacelift_stack.networking.id
  name       = "INFRACOST_API_KEY"
  value      = var.infracost_api_key
  write_only = true
}
