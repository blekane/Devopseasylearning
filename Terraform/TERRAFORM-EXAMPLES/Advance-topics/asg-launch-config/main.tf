provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zone" "current" {}

locals {
  webapp                       = merge(var._webapp_defaults, var.webapp)
  //environment                = "mam-dev"
  amzn_root_disk               = "/dev/xvda"
  tags                         = merge(var._tag_defaults, var.tags)
}




data "aws_vpc" "default" {
  default = true
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}

data "aws_subnet_ids" "test_subnet_ids" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "test_subnet" {
  count = length(data.aws_subnet_ids.test_subnet_ids.ids)
  id    = tolist(data.aws_subnet_ids.test_subnet_ids.ids)[count.index]
}


output "vpc_subnets" {
  value = data.aws_subnet.test_subnet.*.id
}

output "vpc_subnet01" {
  value = data.aws_subnet.test_subnet.0.id
}