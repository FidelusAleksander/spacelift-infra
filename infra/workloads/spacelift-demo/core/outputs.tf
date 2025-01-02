output "spacelift_role_name" {
  description = "The name of the IAM role for Spacelift integration"
  value       = module.spacelift_role.role_name
}
