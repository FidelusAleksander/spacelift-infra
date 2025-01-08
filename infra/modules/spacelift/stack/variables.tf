variable "stack_name" {
  type        = string
  description = "The name of the Spacelift stack"
}

variable "project_root" {
  type        = string
  description = "The location of the Terraform/OpenTofu files within the repository"
}

variable "repository" {
  type        = string
  description = "The name of your infrastructure repo"
  default     = "spacelift-infra"
}

variable "space_id" {
  type        = string
  description = "Place the stack in the specified space_id."
  default     = "root"
}


variable "administrative" {
  type        = bool
  description = "Whether this stack can manage other stacks"
  default     = false
}

variable "autodeploy" {
  type        = bool
  description = "Controls the Spacelift 'autodeploy' option for a stack"
  default     = false
}

variable "autoretry" {
  type        = bool
  description = "Controls the Spacelift 'autoretry' option for a stack"
  default     = false
}

variable "branch" {
  type        = string
  description = "Specify which branch to use within your infrastructure repo"
  default     = "master"
}

variable "context_attachment_ids" {
  type        = list(string)
  description = "A list of context IDs to attach to this stack"
  default     = []
}

variable "description" {
  type        = string
  description = "Specify description of stack"
  default     = null
}

variable "labels" {
  type        = list(string)
  description = "A list of labels for the stack"
  default     = []
}

variable "enable_local_preview" {
  type        = bool
  description = "Indicates whether local preview runs can be triggered on this Stack"
  default     = true
}

variable "manage_state" {
  type        = bool
  description = "Flag to enable/disable manage_state setting in stack"
  default     = true
}

variable "protect_from_deletion" {
  type        = bool
  description = "Flag to enable/disable deletion protection."
  default     = false
}

variable "terraform_smart_sanitization" {
  type        = bool
  description = "Indicates whether runs on this will use terraform's sensitive value system to sanitize the outputs of Terraform state and plans in spacelift instead of sanitizing all fields."
  default     = false
}

variable "terraform_version" {
  type        = string
  description = "Specify the version of Terraform to use for the stack"
  default     = null
}

variable "terraform_workflow_tool" {
  type        = string
  description = "Defines the tool that will be used to execute the workflow. This can be one of OPEN_TOFU, TERRAFORM_FOSS or CUSTOM. Defaults to TERRAFORM_FOSS."
  default     = "OPEN_TOFU"

  validation {
    condition     = contains(["OPEN_TOFU", "TERRAFORM_FOSS", "CUSTOM"], var.terraform_workflow_tool)
    error_message = "Valid values for terraform_workflow_tool are (OPEN_TOFU, TERRAFORM_FOSS, CUSTOM)."
  }
}

variable "aws_integration_id" {
  description = "AWS integration ID"
  type        = string
  default     = null
}

variable "aws_integration_read" {
  description = "Indicates whether this attachment is used for read operations."
  type        = bool
  default     = true
}

variable "aws_integration_write" {
  description = "Indicates whether this attachment is used for write operations."
  type        = bool
  default     = true
}
