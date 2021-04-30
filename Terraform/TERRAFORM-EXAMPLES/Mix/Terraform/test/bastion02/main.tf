provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  type = string
  default = "mam-prod"
}

data "aws_security_group" "mam_prod_bastion_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-bastion-sg"]
  }
}

data "aws_subnet" "mam_prod_vpc_public01" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc-public01"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")
}


resource "aws_instance" "web" {
	subnet_id        = data.aws_subnet.mam_prod_vpc_public01.id
	security_groups  = [data.aws_security_group.mam_prod_bastion_sg.id]
	ami               = var.ec2["ami"]
	instance_type     = var.ec2["instance_type"]
  count             = var.ec2["count"]
  availability_zone = var.ec2["availability_zone"]
  key_name          = var.ec2["key_name"]
  user_data         = data.template_file.user_data.rendered

	tags = {
		Name = "${var.environment}-bastion"
	}
}