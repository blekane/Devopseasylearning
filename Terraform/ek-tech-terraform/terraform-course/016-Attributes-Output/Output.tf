provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  vpc      = true
}

output "eip" {
  value = aws_eip.lb.public_ip
  
}

resource "aws_s3_bucket" "mys3" {
  bucket = "kplabs-attribute-demo-005"
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
  /*
  value2 = aws_s3_bucket.mys3.arn
  value3 = aws_s3_bucket.mys3.region
  value4 = aws_s3_bucket.mys3.website_domain
  value5 = aws_s3_bucket.mys3.id
  */
}