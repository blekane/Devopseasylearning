resource "aws_secretsmanager_secret" "rds_password" {
  # if default = "DefaultPassword!23" is default = null insteat, do not create the RDS password. if default = "DefaultPassword!23", create 1 RDS password because count will be 1
  count       = var.rds_password != null ? 1 : 0
  name        = format("%s-rds-password", local.tags["environment"])
  description = "Password for ${local.tags["environment"]} RDS"
  //kms_key_id  = var.kms_arn != null ? var.kms_arn : null
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  # if default = "DefaultPassword!23" is default = null insteat, do not create the RDS password. if default = "DefaultPassword!23", create 1 RDS password because count will be 1
  count         = var.rds_password != null ? 1 : 0
  secret_id     = aws_secretsmanager_secret.rds_password[count.index].id
  secret_string = var.rds_password
}
