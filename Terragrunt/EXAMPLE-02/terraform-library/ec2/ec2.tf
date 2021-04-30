### Launching a Webserver Instance hosting WordPress in it in public subnet!

data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.tpl")}"
}

resource "aws_instance" "webserver" {
	ami               = var.ami
	key_name          = var.key_name
	instance_type     = var.instance_type
	subnet_id         = data.aws_subnet.subnet_dev_vpc_public.id
	security_groups   = [aws_security_group.webserver_sg.id]
	availability_zone = var.availability_zone
    user_data         = data.template_file.user_data.rendered
    
  tags = {
   Name = "webserver"
  }
  
}

