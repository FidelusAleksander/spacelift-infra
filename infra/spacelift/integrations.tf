## Spacelift Demo Project
resource "spacelift_aws_integration" "spacelift_demo" {
  name = "spacelift_demo_integration"

  role_arn                       = "arn:aws:iam::859006480097:role/spacelift-integration-role"
  generate_credentials_in_worker = false
  space_id                       = module.workload_spaces.spaces["dev"].id
}

# ## Shared Services

# resource "spacelift_aws_integration" "shared_services" {
#   name = "shared_services_integration"

#   role_arn                       = "arn:aws:iam::619071326466:role/spacelift-integration-role"
#   generate_credentials_in_worker = false
#   space_id                       = module.root_spaces.spaces["infrastructure"].id
# }
