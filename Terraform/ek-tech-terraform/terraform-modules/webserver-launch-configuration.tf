resource "aws_launch_configuration" "web" {
  name_prefix = "configuration"

  image_id                    = data.aws_ami.amzlinux2.id
  instance_type               = "t2.nano"
  user_data                   = file("${path.module}/website.sh")
  security_groups             = [aws_security_group.webserver_sg.id]
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
}



