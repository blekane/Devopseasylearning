provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "name" {
  //bucket = "tia-m-25544785"
  bucket   = format("%s-web-content", var.tags["environment"])
  //bucket   = "${var.tags["environment"]}-web-content"
  //RESULT: bucket name = dev-web-content
  
  tags = merge(map("Name", format("%s-web-content", var.tags["environment"])), var.tags)

  }


// RESULT
/*
 tags                        = {
          + "Name"        = "dev-web-content"
          + "environment" = "dev"
          + "project"     = "mam"
          + "terraform"   = "yes"
        }
*/
