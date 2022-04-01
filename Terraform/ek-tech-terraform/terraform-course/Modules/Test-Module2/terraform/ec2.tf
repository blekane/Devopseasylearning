resource "aws_instance" "web" {
	subnet_id         = data.aws_subnet.selected.id
	security_groups   = [data.aws_security_group.selected.id]
	ami               = var.ami
	instance_type     = var.instance_type
    availability_zone = var.availability_zone
    key_name          = var.key_name
	
	tags = {
		Name = "Dev"
	}
}