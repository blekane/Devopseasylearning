resource "aws_secretsmanager_secret" "rds_password" {
  name        = format("%s-rds-password", var.tags["environment"])
  description = "Password for ${var.tags["environment"]} RDS"
  tags = {
    "Terraform" = "true"
    "Project"   = "mam"
  }
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = var.rds_password
}


resource "aws_secretsmanager_secret" "rds_username" {
  name        = format("%s-rds-username", var.tags["environment"])
  description = "Username for ${var.tags["environment"]} RDS"
  tags = {
    "Terraform" = "true"
    "Project"   = "mam"
  }
}

resource "aws_secretsmanager_secret_version" "rds_username" {
  secret_id     = aws_secretsmanager_secret.rds_username.id
  secret_string = var.rds_username
}



