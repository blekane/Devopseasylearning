
variable "environment" {
  type = string
  default = "mam-prod"
}

resource "aws_security_group" "elb_sg" {
  name        = "${var.environment}-elb-sg"
  description = "Allow ports 22 from bastion-sg and 80 from elb-sg"
  vpc_id      = data.aws_vpc.mam_prod.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.environment}-elb-sg"
  }
}


