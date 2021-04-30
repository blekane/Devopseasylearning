# User data
data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")
}

resource "aws_launch_configuration" "web" {
  name_prefix = "web-"

  image_id = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  key_name = "jenkins-key"

  security_groups = [ aws_security_group.allow_http.id ]
  associate_public_ip_address = true

  user_data = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}