module "spacelift_role" {
  source               = "../../modules/aws-spacelift-role"
  spacelift_account_id = "FidelusAleksander"
  spacelift_role_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}
