resource "aws_instance" "bastion_host" {
	subnet_id         = data.aws_subnet.mam_prod_vpc_public01.id
	security_groups   = [data.aws_security_group.mam_prod_bastion_sg.id]
	ami               = var.ami
	instance_type     = var.instance_type
     availability_zone = var.availability_zone
    key_name          = var.key_name

	tags = {
		Name = "${var.environment}-bastion-host"
	}
}