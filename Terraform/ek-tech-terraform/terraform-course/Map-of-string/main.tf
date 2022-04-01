provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
	ami               = var.ec2["ami"]
	instance_type     = var.ec2["instance_type"]
    count             = var.ec2["count"]
    availability_zone = var.ec2["availability_zone"]
    key_name          = var.ec2["key_name"]

	tags = {
		Name = "Dev"
	}
}


/*
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
	ami               = var.ec2.ami
	instance_type     = var.ec2.instance_type
    count             = var.ec2.count
    availability_zone = var.ec2.availability_zone
    key_name          = var.ec2.key_name

	tags = {
		Name = "Dev"
	}
}
*/