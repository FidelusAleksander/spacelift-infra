resource "spacelift_aws_integration" "aws_demo" {
  name = "aws_demo_integration"

  role_arn                       = "arn:aws:iam::859006480097:role/spacelift-integration-role"
  generate_credentials_in_worker = false
  space_id                       = spacelift_space.workloads-dev.id
}

resource "spacelift_aws_integration_attachment" "aws_demo_aws_fastapi" {
  integration_id = spacelift_aws_integration.aws_demo.id
  stack_id       = spacelift_stack.aws_fastapi.id
  read           = true
  write          = true
}

resource "spacelift_aws_integration_attachment" "aws_demo_storage" {
  integration_id = spacelift_aws_integration.aws_demo.id
  stack_id       = spacelift_stack.storage.id
  read           = true
  write          = true
}

resource "spacelift_aws_integration_attachment" "aws_demo_networking" {
  integration_id = spacelift_aws_integration.aws_demo.id
  stack_id       = spacelift_stack.networking.id
  read           = true
  write          = true
}
