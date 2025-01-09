

moved {
  from = spacelift_stack.aws_fastapi
  to   = module.stacks["spacelift_demo_aws_fastapi"].spacelift_stack.this
}

moved {
  from = spacelift_stack.networking
  to   = module.stacks["spacelift_demo_networking"].spacelift_stack.this
}

moved {
  from = spacelift_stack.shared_services_core
  to   = module.stacks["shared_services_core"].spacelift_stack.this
}

moved {
  from = spacelift_stack.shared_services_github_runners
  to   = module.stacks["shared_services_github_runners"].spacelift_stack.this
}

moved {
  from = spacelift_stack.spacelift_demo_core
  to   = module.stacks["spacelift_demo_core"].spacelift_stack.this
}

moved {
  from = spacelift_stack.storage
  to   = module.stacks["spacelift_demo_storage"].spacelift_stack.this
}



moved {
  from = spacelift_aws_integration_attachment.shared_services_attachments["shared_services_core"]
  to   = module.stacks["shared_services_core"].spacelift_aws_integration_attachment.this[0]
}

moved {
  from = spacelift_aws_integration_attachment.shared_services_attachments["shared_services_github_runners"]
  to   = module.stacks["shared_services_github_runners"].spacelift_aws_integration_attachment.this[0]
}

moved {
  from = spacelift_aws_integration_attachment.spacelift_demo_attachments["spacelift_demo_core"]
  to   = module.stacks["spacelift_demo_core"].spacelift_aws_integration_attachment.this[0]
}


moved {
  from = spacelift_aws_integration_attachment.spacelift_demo_attachments["spacelift_demo_aws_fastapi"]
  to   = module.stacks["spacelift_demo_aws_fastapi"].spacelift_aws_integration_attachment.this[0]
}


moved {
  from = spacelift_aws_integration_attachment.spacelift_demo_attachments["spacelift_demo_networking"]
  to   = module.stacks["spacelift_demo_networking"].spacelift_aws_integration_attachment.this[0]
}


moved {
  from = spacelift_aws_integration_attachment.spacelift_demo_attachments["spacelift_demo_storage"]
  to   = module.stacks["spacelift_demo_storage"].spacelift_aws_integration_attachment.this[0]
}
