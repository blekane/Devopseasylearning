provider "aws" {
  region = "us-east-1"
}

variable "dev" {
  description = "Create ec2 for Dev"
  type = number
  default = 2
}

variable "prod" {
  description = "Create ec2 for prod"
  type = number
  default = 2
}


locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  count         = [var.prod == 2 ? 1 : 0]
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}