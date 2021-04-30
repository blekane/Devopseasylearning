provider "aws" {
  region = "us-east-1"
}


locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key
  security_groups = [ aws_security_group.web_traffict.name ]

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}


variable "ingress_rules" {
  type = list(number)
  description = "list of ingress ports"
  default = [22, 80, 8080, 3306, 443, 23]
}

variable "egress_rules" {
  description = "list of egress ports"
  type = list(number)
  default = [0]
}


resource "aws_security_group" "web_traffict" {
  name = "Secure Server"
  dynamic "ingress" {
      iterator = port
      for_each = var.ingress_rules
      content {
          from_port   = port.value
          to_port     = port.value
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

    dynamic "egress" {
      iterator = port
      for_each = var.egress_rules
      content {
          from_port   = port.value
          to_port     = port.value
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
}







