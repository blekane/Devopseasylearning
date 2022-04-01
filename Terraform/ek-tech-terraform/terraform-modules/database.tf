# resource "aws_db_instance" "db" {

#   identifier     = format("%s-postgres-identifier", var.environment)
#   engine         = var.engine
#   engine_version = var.engine_version
#   instance_class = var.instance_class

#   allocated_storage     = var.allocated_storage
#   max_allocated_storage = var.max_allocated_storage

#   name              = var.name
#   username          = var.username
#   password          = var.password
#   storage_encrypted = var.storage_encrypted
#   storage_type      = var.storage_type
#   port              = var.port

#   multi_az               = var.multi_az
#   vpc_security_group_ids = [aws_security_group.database_sg.id]
#   db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

#   maintenance_window      = var.maintenance_window
#   backup_window           = var.backup_window
#   backup_retention_period = var.backup_retention_period
#   apply_immediately       = var.apply_immediately

#   skip_final_snapshot = var.skip_final_snapshot
#   deletion_protection = var.deletion_protection
#   publicly_accessible = var.publicly_accessible
# }

# resource "aws_db_subnet_group" "db_subnet_group" {
#   name       = format("%s-db-subnet-group", var.environment)
#   subnet_ids = aws_subnet.private.*.id
#   tags = {
#     Name        = format("%s-db-subnet-group", var.environment)
#     Environment = var.environment
#     Owner       = var.owner
#     "Manage by" : "Terraform"
#   }
# }



