resource "spacelift_aws_integration" "spacelift_demo" {
  name = "aws_demo_integration"

  role_arn                       = "arn:aws:iam::859006480097:role/spacelift-role"
  generate_credentials_in_worker = false
  space_id                       = spacelift_space.workloads-dev.id
}

resource "spacelift_aws_integration_attachment" "spacelift_demo_core" {
  integration_id = spacelift_aws_integration.spacelift_demo_core.id
  stack_id       = spacelift_stack.networking.id
  read           = true
  write          = true
}


resource "spacelift_aws_integration_attachment" "spacelift_demo_aws_fastapi" {
  integration_id = spacelift_aws_integration.aws_demo.id
  stack_id       = spacelift_stack.aws_fastapi.id
  read           = true
  write          = true
}

resource "spacelift_aws_integration_attachment" "spacelift_demo_storage" {
  integration_id = spacelift_aws_integration.aws_demo.id
  stack_id       = spacelift_stack.storage.id
  read           = true
  write          = true
}

resource "spacelift_aws_integration_attachment" "spacelift_demo_networking" {
  integration_id = spacelift_aws_integration.aws_demo.id
  stack_id       = spacelift_stack.networking.id
  read           = true
  write          = true
}
