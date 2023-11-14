resource "spacelift_stack" "aws_fastapi" {
  name         = "AWS Fastapi"
  description  = "Provisions a FastAPI application on AWS"
  repository   = "aws-fastapi"
  project_root = "infra"
  branch       = "master"
  autodeploy   = true
  space_id     = spacelift_space.workloads-dev.id
}

module "aws_fastapi_integration" {
  source    = "./modules/aws_integration"
  role_name = "aws-fastapi-spacelift-integration"
  stack_id  = spacelift_stack.aws_fastapi.id
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  space_id = spacelift_space.workloads-dev.id
}
