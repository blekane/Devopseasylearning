provider "aws" {
  region = var.region
}

data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.tpl")}"
}

resource "aws_instance" "ec2_jenkins" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # key name
  key_name = var.key_name

  user_data         = data.template_file.user_data.rendered

  tags = {
    Name = "Jenkins-Master"
  }
}