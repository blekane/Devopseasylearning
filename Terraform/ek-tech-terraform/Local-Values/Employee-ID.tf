provider "aws" {
    region = "us-east-1"
}

locals {
    employee_id = "53747-tia"
}

resource "aws_vpc" "ProdVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "${local.employee_id}-Production"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ProdVpc.id
  tags = {
    Name = "${local.employee_id}-main"
  }
}

resource "aws_route_table" "PordRouteTable" {
  vpc_id = aws_vpc.ProdVpc.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.employee_id}-MyProRoute"
  }
}

resource "aws_subnet" "PuiblicSubnet1" {
  vpc_id            =  aws_vpc.ProdVpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${local.employee_id}-ProdSubnet"
  }
}


resource "aws_instance" "web-server-instance" {
  ami               = "ami-0dba2cb6798deb6d8"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "jenkins-key"

  network_interface {
    device_index         = 0 # first interface (eth0, eth1 ...)
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo your very first web server > /var/www/html/index.html'
                EOF
  tags = {
    Name = "${local.employee_id}-web-server"
  }
}
