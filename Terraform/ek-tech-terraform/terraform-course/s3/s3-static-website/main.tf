provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = var.webside_domain
  acl = "public-read"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.webside_domain}/*"
        }
    ]
}
POLICY

  versioning {
    enabled = true
    mfa_delete = false
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
   tags = {
    Type = "LOG"
    Tier = "STANDARD"
  }

} 


resource "aws_s3_bucket_object" "index_html" {
  bucket        = var.webside_domain
  key           = "index.html"
  content_type  = "text/html"
  source        = "index.html"
  etag          =  filemd5("index.html")
}

resource "aws_s3_bucket_object" "error_html" {
  bucket        = var.webside_domain
  key           = "error.html"
  content_type  = "text/html"
  source        = "error.html"
  etag          =  filemd5("error.html")
}


/*
{
  "Version": "2012-10-17",
  "Statement": [{
      "Sid": "PublicReadAccessForWebside",
      "Effect": "Allow",
      "Action": "s3:GetObject,
      "Principal": "*",
      "Resource": ["arn:aws:s3:::${var.webside_domain}/*"]
    }

  ]
}*/