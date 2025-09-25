locals {
  stack_labels = var.infracost.enabled ? concat(var.labels, ["infracost"]) : var.labels

}

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
  labels                       = local.stack_labels
  administrative               = var.administrative
  enable_local_preview         = var.enable_local_preview
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
  count = var.aws_integration_id != null ? 1 : 0

  integration_id = var.aws_integration_id
  stack_id       = spacelift_stack.this.id
  read           = var.aws_integration_read
  write          = var.aws_integration_write
}


resource "spacelift_environment_variable" "infracost_api_key" {
  count      = var.infracost.enabled ? 1 : 0
  stack_id   = spacelift_stack.this.id
  name       = "INFRACOST_API_KEY"
  value      = var.infracost.api_key
  write_only = true
}

# Used to trigger the deletion of resources when a stack is destroyed
resource "spacelift_stack_destructor" "this" {
  depends_on = [
    spacelift_stack.this,
    spacelift_aws_integration_attachment.this,
    spacelift_environment_variable.this,
    spacelift_context_attachment.this
  ]
  stack_id = spacelift_stack.this.id
}

# Triggers the stack after creation
resource "spacelift_run" "this" {
  stack_id = spacelift_stack.this.id
}
