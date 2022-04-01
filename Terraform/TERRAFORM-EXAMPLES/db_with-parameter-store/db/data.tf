data "aws_ssm_parameter" "db_password" {
  name = "/${var.environment}/db_password"
}

data "aws_ssm_parameter" "db_user" {
  name = "/${var.environment}/db_user"
}