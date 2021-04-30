resource "aws_db_subnet_group" "mysqlsubnet" {
  name       = "${var.environment}-mysqlsubnet"
  subnet_ids = [data.aws_subnet.mam_prod_vpc_public01.id, data.aws_subnet.mam_prod_vpc_public02.id]
}

resource "aws_db_instance" "mysql" {
  depends_on = [
    data.aws_secretsmanager_secret.rds_password,
    data.aws_secretsmanager_secret_version.rds_password,
    data.aws_secretsmanager_secret.rds_username,
    data.aws_secretsmanager_secret_version.rds_username
  ]

  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  storage_type           = var.storage_type
  allocated_storage      = var.allocated_storage
  name                   = var.name
  port                   = var.port
  db_subnet_group_name   = aws_db_subnet_group.mysqlsubnet.name
  vpc_security_group_ids = [data.aws_security_group.mam_prod_rds_sg.id]
  password               = data.aws_secretsmanager_secret_version.rds_password.secret_string
  username               = data.aws_secretsmanager_secret_version.rds_username.secret_string
  
  // This will take the RDS final snapshot when you destroy the RDS
  final_snapshot_identifier = "${var.environment}-mysql-final-snapshot"

  tags = {
    Name = "${var.environment}-mysql"
  }
}
