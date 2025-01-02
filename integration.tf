resource "spacelift_aws_integration" "aws_demo" {
  name = "aws_demo_integration"

  role_arn                       = "arn:aws:iam::859006480097:role/spacelift-integration-role"
  generate_credentials_in_worker = false
  space_id                       = spacelift_space.workloads-dev.id
}

