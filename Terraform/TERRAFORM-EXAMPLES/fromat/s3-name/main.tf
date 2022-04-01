provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "name" {
  //bucket = "tia-m-25544785"
  bucket   = format("%s-web-content", var.tags["environment"])
  //RESULT: bucket name = dev-web-content
  tags = {
    "terraform" = var.tags["terraform"]
  }
}
