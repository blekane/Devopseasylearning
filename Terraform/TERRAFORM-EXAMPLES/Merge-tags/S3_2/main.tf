provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "name" {
  //bucket = "tia-m-25544785"
  bucket   = format("%s-web-content", var.tags["environment"])
  //bucket   = "${var.tags["environment"]}-web-content"
  //RESULT: bucket name = dev-web-content
  
  tags = merge(map("bucket-name", format("%s-web-content", var.tags["environment"])), var.tags)

  }

// RESULT
/*
tags                        = {
            "application"   = "mam-dev"
            "bucket-name"   = "dev-web-content"
            "environment"   = "dev"
            "owner"         = "norm.nadeau@tcs.com"
            "project"       = "mam"
            "t_AppID"       = "SVC02524232"
            "t_cost_centre" = "9516.9130."
            "t_dcl"         = "2"
            "t_environment" = "DEV"
            "terraform"     = "tree"
        }
*/

