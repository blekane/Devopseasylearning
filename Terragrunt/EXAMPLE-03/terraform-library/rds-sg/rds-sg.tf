variable "environment" {
  type = string
  default = "mam-prod"
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Allow ports 22 from bastion-sg and 5432 from web-sg"
  vpc_id      = data.aws_vpc.mam_prod.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [data.aws_security_group.mam_prod_web_sg.id]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [data.aws_security_group.mam-prod-bastion-sg.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.environment}-rds-sg"
  }
}

