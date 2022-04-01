provider "aws" {
  region = "us-east-1"
}


data "aws_caller_identity" "current" {}

data "aws_region" "current" {}


locals {
  tags                = merge(var._tag_defaults, var.tags)
  region              = data.aws_region.current.id
  account_id          = data.aws_caller_identity.current.account_id
}
