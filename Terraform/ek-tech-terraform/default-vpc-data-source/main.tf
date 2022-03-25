provider "aws" {
  region = "us-east-1"
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

output "vpc_subnet02" {
  value = data.aws_subnet.test_subnet.1.id
}

output "vpc_subnet03" {
  value = data.aws_subnet.test_subnet.2.id
}