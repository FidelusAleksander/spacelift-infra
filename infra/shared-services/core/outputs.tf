output "spacelift_role_arn" {
  description = "Spacelift AWS IAM role ARN"
  value       = module.spacelift_role.role_arn
}
