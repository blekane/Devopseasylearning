locals {
  common = yamldecode(file("${get_parent_terragrunt_dir()}/common.yaml"))
  region = get_env("AWS_REGION", get_env("AWS_DEFAULT_REGION", "us-east-1"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "${local.common.environment}-${get_aws_account_id()}-${local.region}-tfstate"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region}"
    encrypt        = true
    dynamodb_table = "${local.common.environment}-${get_aws_account_id()}-${local.region}-tfstate"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "${local.region}"
#  version = "2.60"
}
EOF
}

