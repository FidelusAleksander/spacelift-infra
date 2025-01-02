variable "infracost_api_key" {
  description = "Infracost API key"
  sensitive   = true
}


locals {
  default_terraform_workflow_tool = "OPEN_TOFU"
  default_terraform_version       = "1.8.7"
}
