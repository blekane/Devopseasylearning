provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-first-server" {
  ami               = "ami-04d29b6f966df1537"
  instance_type     = "t2.micro"
  key_name          = "jenkins-key"

  tags = merge(map("Name", format("%s-bastion", var._tag_defaults["environment"])), local.tags)
}

locals {
  tags                = merge(var._tag_defaults, var.tags)
}
