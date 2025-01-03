locals {
  environment = var.environment != null ? var.environment : "gh-shared"
  aws_region  = var.aws_region
}

resource "random_id" "random" {
  byte_length = 20
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = "${local.environment}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_hostnames    = true
  enable_nat_gateway      = true
  map_public_ip_on_launch = false
  single_nat_gateway      = true
}

module "runners" {
  source                          = "philips-labs/github-runner/aws"
  version                         = "v6.0.1"
  create_service_linked_role_spot = true
  aws_region                      = local.aws_region
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets

  prefix = local.environment

  github_app = {
    key_base64     = var.github_app.key_base64
    id             = var.github_app.id
    webhook_secret = random_id.random.hex
  }

  webhook_lambda_zip                = "./lambdas-download/webhook.zip"
  runner_binaries_syncer_lambda_zip = "./lambdas-download/runner-binaries-syncer.zip"
  runners_lambda_zip                = "./lambdas-download/runners.zip"


  # enable access to the runners via SSM
  enable_ssm_on_runners = true

  instance_types = ["m7a.large", "m5.large"]

  # prefix GitHub runners with the environment name
  runner_name_prefix = "${local.environment}_"

}
