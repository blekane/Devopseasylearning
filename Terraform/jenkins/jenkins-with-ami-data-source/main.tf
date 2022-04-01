provider "aws" {
  region = var.region
}

data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.tpl")}"
}

resource "aws_instance" "jenkins-instance" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = "t2.micro"
  key_name        = var.keyname
  #vpc_id          = "${aws_vpc.development-vpc.id}"
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh_jenkins.id]
  //subnet_id          = aws_subnet.public-subnet-1.id
  user_data         = data.template_file.user_data.rendered

  associate_public_ip_address = true
  tags = {
    Name = "Jenkins-Instance"
  }
}


