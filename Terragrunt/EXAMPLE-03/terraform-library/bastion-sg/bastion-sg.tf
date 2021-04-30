variable "environment" {
  type = string
  default = "mam-prod"
}

resource "aws_security_group" "bastion_sg" {
  name        = "${var.environment}-bastion-sg"
  description = "Allow SSH"
  vpc_id      = data.aws_vpc.mam_prod.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    "Name" = "${var.environment}-bastion-sg"
  }
}
