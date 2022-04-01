# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type # For simple variable
  #instance_type = var.instance_type_list[1]      # For List
  #nstance_type = var.instance_type_map["prod"]   # For Map
  user_data = file("${path.module}/website.sh")
  key_name  = var.instance_keypair

  depends_on = [
    aws_security_group.vpc-ssh,
    aws_security_group.vpc-web
  ]

  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  count                  = var.web_server_count
  tags = {
    "Name" = format("zedcloud-%s-webserver%02d", var.environment, count.index + 1)
    # "Name" = format("zedcloud-%s-webserver%03d", var.environment, count.index + 1)
    # "Name" = format("zedcloud-%s-webserver%d", var.environment, count.index + 1)
    # "Name" = "zedcloud-${var.environment}-${count.index + 1}"
    # "Name" = "zedcloud-${var.environment}-0${count.index + 1}"
  }
}

