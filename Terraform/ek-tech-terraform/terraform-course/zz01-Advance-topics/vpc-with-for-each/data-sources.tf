data "aws_vpc" "mam_prod" {
  filter {
    name = "tag:Name"
    values = ["My VPC"]
  }
}

data "aws_subnet_ids" "rds_subnets" {
  vpc_id = data.aws_vpc.mam_prod.id
}

data "aws_subnet" "rds" {
  for_each = data.aws_subnet_ids.rds_subnets.ids
  id       = each.value
}

