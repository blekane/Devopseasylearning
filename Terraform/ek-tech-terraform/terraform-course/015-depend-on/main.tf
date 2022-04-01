provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "my_account" {}
  

resource "aws_s3_bucket" "bucket1" {
  bucket = "${data.aws_caller_identity.my_account.id}-bucket1"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = data.aws_caller_identity.my_account.id
  depends_on = [ 
    aws_s3_bucket.bucket1
   ]
}

