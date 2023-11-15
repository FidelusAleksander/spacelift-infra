resource "spacelift_stack" "storage" {
  name                    = "Storage"
  description             = "Provisions Storage Resources"
  repository              = "spacelift-aws-demo"
  project_root            = "storage"
  branch                  = "master"
  autodeploy              = true
  space_id                = spacelift_space.workloads-dev.id
  terraform_workflow_tool = "OPEN_TOFU"
  terraform_version       = "1.6.0-alpha5"
}

module "storage_integration" {
  source    = "./modules/aws_integration"
  role_name = "storage-spacelift-integration"
  stack_id  = spacelift_stack.storage.id
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]
  space_id = spacelift_space.workloads-dev.id
}
