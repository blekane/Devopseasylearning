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

data "aws_security_group" "mam_prod_rds_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-rds-sg"]
  }
}

data "aws_subnet" "mam_prod_vpc_public02" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc-public02"]
  }
}

data "aws_subnet" "mam_prod_vpc_public01" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc-public01"]
  }
}

