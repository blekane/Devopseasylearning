
resource "aws_instance" "web" {
	ami               = var.ec2_string_var.ami
	instance_type     = var.ec2_list_var.instance_type[2]
    count             = var.ec2_string_var.count
    availability_zone = var.ec2_list_var.availability_zone[2]
    key_name          = var.ec2_string_var.key_name

	tags = {
		Name = "Dev"
	}
}


/*
resource "aws_instance" "web" {
	ami               = var.ec2_string_var["ami"]
	instance_type     = var.ec2_list_var.instance_type[2]
    count             = var.ec2_string_var["count"]
    availability_zone = var.ec2_list_var.availability_zone[2]
    key_name          = var.ec2_string_var["key_name"]

	tags = {
		Name = "Dev"
	}
}
*/


/*
resource "aws_instance" "web" {
	ami               = var.ec2_string_var.ami
	instance_type     = var.ec2_list_var.instance_type.0
    count             = var.ec2_string_var.count
    availability_zone = var.ec2_list_var.availability_zone.1
    key_name          = var.ec2_string_var.key_name

	tags = {
		Name = "Dev"
	}
}
*/