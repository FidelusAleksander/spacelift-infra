moved {
  from = spacelift_stack.spacelift_demo_core
  to   = module.stack.spacelift_stack.this
}

moved {
  from = spacelift_aws_integration_attachment.spacelift_demo_attachments["spacelift_demo_core"]
  to   = module.stack.spacelift_aws_integration_attachment.this[0]
}
