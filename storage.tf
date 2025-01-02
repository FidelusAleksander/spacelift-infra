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

resource "spacelift_aws_integration_attachment" "aws_demo_storage" {
  integration_id = spacelift_aws_integration.this.id
  stack_id       = spacelift_stack.aws_fastapi.id
  read           = true
  write          = true
}
