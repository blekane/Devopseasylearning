
# DB Security group
resource "aws_security_group" "database_sg" {
  name_prefix = "${var.environment}-database-sg"
  description = "Allow all inbound traffic from port 80"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = format("%s-database-security-group", var.environment)
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "database_allow_all_db" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.database_sg.id
}

resource "aws_security_group_rule" "database_allow_all_outbound_db" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.database_sg.id
}


