/*
data "template_file" "bastion_public_key" {
  template = "${file("~/.ssh/id_rsa.pub")}"
}

# AWS
data "aws_ami" "amazon_linux" {
  owners      = ["679593333241"]
  most_recent = true
  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
*/