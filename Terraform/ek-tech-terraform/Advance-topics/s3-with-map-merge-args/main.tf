provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "repository" {
  bucket = format("%s-repository-%s-%s-%s", var.tags["environment"], var.tags["project-id"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  tags   = merge(map("Name", format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)), map("csp_exception", "true"), map("Others tags", "just for for testing"), var.tags)

  versioning {
    enabled = true
  }
}
