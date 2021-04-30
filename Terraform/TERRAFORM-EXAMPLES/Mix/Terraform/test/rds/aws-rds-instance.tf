resource "aws_db_subnet_group" "postgres" {
  name       = format("%s-rds-studio", local.tags["environment"])
  subnet_ids = data.aws_subnet_ids.rds_subnets.ids

  tags = merge(map("Name", format("%s-rds-studio", local.tags["environment"])), local.tags)

}

resource "aws_db_instance" "postgres" {
  identifier_prefix               = format("%s-rds-studio-", local.tags["environment"])
  db_subnet_group_name            = aws_db_subnet_group.postgres.id
  storage_encrypted               = local.rds["storage_encrypted"]
  kms_key_id                      = tobool(local.rds["storage_encrypted"]) && var.kms_arn != null && local.rds["snapshot_identifier"] == null ? var.kms_arn : null
  vpc_security_group_ids          = [module.sg-rds.security_group.id]
  allocated_storage               = local.rds["snapshot_identifier"] == null ? local.rds["allocated_storage"] : null
  max_allocated_storage           = local.rds["snapshot_identifier"] == null ? local.rds["allocated_storage"] * local.rds["max_allocated_storage"] : null
  engine                          = local.rds["engine"]
  engine_version                  = local.rds["engine_version"]
  license_model                   = local.rds["license_model"]
  instance_class                  = local.rds["instance_class"]
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  name                            = local.rds["name"]
  port                            = local.rds["port"]
  password                        = data.aws_secretsmanager_secret_version.rds-password.secret_string
  username                        = local.rds["username"]
  apply_immediately               = local.rds["apply_immediately"]
  multi_az                        = local.rds["multi_az"]
  snapshot_identifier             = local.rds["snapshot_identifier"]
  maintenance_window              = local.rds["maintenance_window"]
  backup_window                   = local.rds["backup_window"]
  backup_retention_period         = local.rds["backup_retention_period"]
  final_snapshot_identifier       = format("%s-rds-studio-FINAL", local.tags["environment"])

  tags = merge(map("Name", format("%s-rds-studio", local.tags["environment"])), local.tags)
}