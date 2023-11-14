variable "role_name" {
  type        = string
  description = "The name of the IAM role to be created"
}

variable "stack_id" {
  type        = string
  description = "The ID of the stack to which the IAM role will be attached"
}

variable "iam_policy_arns" {
  type        = list(string)
  description = "A list of IAM policy ARNs to attach to the IAM role"
}
