provider "aws" {
	version = "~> 2.65"
	region  = var.region
}

/*
name = "${terraform.workspace}-instance"
this will will take the workspace name and add instance as tag
- def-instance for dev environment
- prod-instance for prod environment
*/
locals {
	name = "${terraform.workspace}-instance"
}

resource "aws_instance" "main" {
	ami           = var.ami
	instance_type = var.instance_type

	tags = {
		//- def-instance for dev environment
		//- prod-instance for prod environment
		Name = local.name
	}
}