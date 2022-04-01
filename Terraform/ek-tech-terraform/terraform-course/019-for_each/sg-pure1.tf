provider "aws" {
  region = "us-east-1"
}


variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443, 22]
}

variable "egress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [0]
}


resource "aws_vpc" "test" {
  cidr_block = "172.16.0.0/16"
  tags = {
    "Name" = "dev-vpc"
  }
}

resource "aws_security_group" "test" {
  name = "Web-sg"
  vpc_id = aws_vpc.test.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}