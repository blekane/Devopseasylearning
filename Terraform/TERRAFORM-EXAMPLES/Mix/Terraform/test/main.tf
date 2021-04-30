provider "aws" {
  region = "us-east-1"
}


variable "rds_password" {
  type        = string
  description = "Master DB password for RDS."
  default     = "DefaultPassword!23"
}

variable "rds_username" {
  type        = string
  description = "Master DB Username for RDS."
  default     = "admin"
}


variable "tags" {
  type = map(string)
  default = {
      environment = "prod-mam"
  }
}


resource "aws_secretsmanager_secret" "rds_password" {
  name        = format("%s-rds-password", var.tags["environment"])
  description = "Password for ${var.tags["environment"]} RDS"
  tags = {
    "Terraform" = "true"
    "Project"   = "MAM"
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
    "Project"   = "MAM"
  }
}

resource "aws_secretsmanager_secret_version" "rds_username" {
  secret_id     = aws_secretsmanager_secret.rds_username.id
  secret_string = var.rds_username
}



