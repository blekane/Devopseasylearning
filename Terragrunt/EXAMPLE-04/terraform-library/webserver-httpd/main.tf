resource "aws_instance" "webserver_httpd" {
    subnet_id         = data.aws_subnet.mam_prod_vpc_public01.id
	security_groups   = [data.aws_security_group.mam_prod_web_sg.id]
	ami               = var.ami
	instance_type     = var.instance_type
    availability_zone = var.availability_zone
    key_name          = var.key_name
    user_data         = data.template_file.user_data.rendered

	tags = {
		Name = "${var.environment}-apache-httpd"
	}
}