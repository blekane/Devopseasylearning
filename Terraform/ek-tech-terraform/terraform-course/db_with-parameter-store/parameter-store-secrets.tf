provider "aws" {
  region = "us-east-1"
}


resource "aws_ssm_parameter" "db_user" {
  name  = "/${var.environment}/db_user"
  type  = "String"
  value = var.db_user
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.environment}/db_password"
  type  = "String"
  value = var.db_password
}