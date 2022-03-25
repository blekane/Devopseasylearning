provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = merge(var.default_tags,map("Name", var.vpc_name))
}
#####VPC FLOW LOGS####