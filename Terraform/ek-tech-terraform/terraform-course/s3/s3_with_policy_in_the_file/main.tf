provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "my_account" {}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "dev-backend-${data.aws_caller_identity.my_account.id}"
  //bucket = "dev-backend-${data.aws_caller_identity.my_account.account_id}"

  acl = "public-read"

  versioning {
    enabled    = true
    mfa_delete = false
  }

  lifecycle_rule {
    enabled = true
    prefix  = "files/"

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 365
    }
  }

  tags = {
    Type = "LOG"
    Tier = "STANDARD"
  }
}


resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = file("s3_policy.json")

}

