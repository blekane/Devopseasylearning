provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "name" {
  vpc      = true
  lifecycle {
    prevent_destroy = "false"
  }
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.s3_bucket_prefix}-${var.environment}-${var.s3_region}"

  lifecycle {
    prevent_destroy = "true"
  }
}

resource "aws_instance" "name" {
  ami = "ami-0be2609ba883822ec "
  
  lifecycle {
    prevent_destroy = "true"
  }
}