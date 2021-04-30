provider "aws" {
  region = var.s3_region[0]
}

resource "aws_s3_bucket" "bucket1" {
  bucket = var.s3_bucket_prefix
  
  lifecycle {
      prevent_destroy = true
  }

  tags = {
    env          = lookup(var.s3_tags, "environment")
    project_name = lookup(var.s3_tags, "project")
    region       = var.s3_region[0]
  }
  
}



