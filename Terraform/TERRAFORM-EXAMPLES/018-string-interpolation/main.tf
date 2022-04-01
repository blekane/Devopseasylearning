provider "aws" {
  region = var.s3_region
}

variable "environment" {
  type    = string
  default = "test"
}

variable "s3_bucket_prefix" {
  type        = string
  description = "Prefix of the S3 bucket"
  default     = "packt-terraform-backbone"
}

variable "s3_region" {
  type = string
  default = "us-east-1"
}

locals {
  s3_tags = {
    created_by  = "terraform"
    environment = "test"
  }
}


resource "aws_s3_bucket" "main" {
  bucket = "${var.s3_bucket_prefix}-${var.environment}-${var.s3_region}"
  acl    = "private"
  tags   = local.s3_tags
  

  lifecycle {
    prevent_destroy = "true"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "state"
    prefix  = "state/"
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }
}