provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "my_account" {}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "dev-backend-${data.aws_caller_identity.my_account.id}"
  //bucket = "dev-backend-${data.aws_caller_identity.my_account.account_id}"

  versioning {
    enabled = true
    mfa_delete = false
  }
  
  tags = {
    Type = "LOG"
    Tier = "STANDARD"
  }
}

resource "aws_s3_bucket_object" "readme_file" {
  bucket = aws_s3_bucket.my_bucket.bucket
  for_each = fileset("${path.module}/files-for-uploading/", "*")
  key     = "files-uploaded/${each.value}"
  source  = each.value
  etag    = filemd5("${path.module}/files-for-uploading/${each.value}")
}