resource "spacelift_aws_integration" "this" {
  name = var.role_name

  # We need to set the ARN manually rather than referencing the role to avoid a circular dependency
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  generate_credentials_in_worker = false
}

data "spacelift_aws_integration_attachment_external_id" "my_stack" {
  integration_id = spacelift_aws_integration.this.id
  stack_id       = var.stack_id
  read           = true
  write          = true
  space_id       = var.space_id
}



# Attach the integration to any stacks or modules that need to use it
resource "spacelift_aws_integration_attachment" "my_stack" {
  integration_id = spacelift_aws_integration.this.id
  stack_id       = var.stack_id
  read           = true
  write          = true

  # The role needs to exist before we attach since we test role assumption during attachment.
  depends_on = [
    aws_iam_role.this
  ]
}
