provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  type    = string
  default = "man-prod"
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

resource "aws_db_instance" "mysql" {
  depends_on = [
    data.aws_secretsmanager_secret.rds_password,
    data.aws_secretsmanager_secret_version.rds_password,
    data.aws_secretsmanager_secret.rds_username,
    data.aws_secretsmanager_secret_version.rds_username
  ]

  identifier        = "demodb"
  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  storage_type      = "standard"
  allocated_storage = 5
  name              = "demodb"
  port              = "3306"
  password          = data.aws_secretsmanager_secret_version.rds_password.secret_string
  username          = data.aws_secretsmanager_secret_version.rds_username.secret_string
  
  // This will take the RDS final snapshot when you destroy the RDS
  final_snapshot_identifier = "${var.environment}-mysql-final-snapshot"

  tags = {
    Name = "${var.environment}-mysql"
  }
}
