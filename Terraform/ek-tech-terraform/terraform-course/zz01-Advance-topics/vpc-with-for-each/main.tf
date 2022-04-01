provider "aws" {
  region = "us-east-1"
}

locals {
  rds_subnet_ids      = [for e in data.aws_subnet.rds : e.id]
}
