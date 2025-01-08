resource "spacelift_stack" "this" {
  name        = var.stack_name
  branch      = var.branch
  repository  = var.repository
  description = var.description

  project_root = var.project_root

  autodeploy                   = var.autodeploy
  autoretry                    = var.autoretry
  space_id                     = var.space_id
  terraform_workflow_tool      = var.terraform_workflow_tool
  terraform_version            = var.terraform_version
  labels                       = var.labels
  administrative               = var.administrative
  enable_local_preview         = var.local_preview_enabled
  manage_state                 = var.manage_state
  protect_from_deletion        = var.protect_from_deletion
  terraform_smart_sanitization = var.terraform_smart_sanitization
}

resource "spacelift_context_attachment" "this" {
  # Iteration so we have an index for priority
  for_each = {
    for i, context_id in var.context_attachment_ids : context_id => i
  }
  context_id = each.key
  stack_id   = spacelift_stack.this.id
  priority   = each.value
}

resource "spacelift_aws_integration_attachment" "this" {
  integration_id = var.aws_integration.integration_id
  stack_id       = spacelift_stack.this.id
  read           = var.aws_integration.read
  write          = var.aws_integration.write
}
