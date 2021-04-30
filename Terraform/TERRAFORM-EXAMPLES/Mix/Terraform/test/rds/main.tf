data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = "prod-mam-rds-password"
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = "prod-mam-rds-username"
}

data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}

# Get VPC information
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

# Get Security Group information
data "aws_security_group" "bastion" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Name = "*bastion*"
  }
}

data "aws_security_group" "webapp" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    Name = "*webapp*"
  }
}

# Get RDS Subnet IDs based on VPC ID
data "aws_subnet_ids" "rds_subnets" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${local.tags["environment"]}-rds*"
  }
}
data "aws_subnet" "rds" {
  for_each = data.aws_subnet_ids.rds_subnets.ids
  id       = each.value
}

locals {
  rds                 = merge(var._rds_defaults, var.rds)
  tags                = merge(var._tag_defaults, var.tags)
  region              = data.aws_region.current.id
  account_id          = data.aws_caller_identity.current.account_id
  timestamp           = timestamp()
  timestamp_sanitized = replace(local.timestamp, "/[-| |T|Z|:]/", "")
  rds_subnet_ids      = [for e in data.aws_subnet.rds : e.id]
  isprod              = local.tags["t_environment"] == "PRD" ? true : false
}

