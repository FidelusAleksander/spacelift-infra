variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "spacelift_account_id" {
  description = "The Spacelift account ID for the assume role policy"
  type        = string
}

variable "spacelift_role_policy_arns" {
  description = "A list of policy ARNs to attach to the IAM role"
  type        = list(string)
}
