/*
provider "aws" {
  region = var.region
}
*/

module "vpc_basic02" {
  //source = "./vpc"
  source        = "github.com/turnbullpress/tf_vpc_basic.git?ref=v0.0.1"
  name          = "web-vpc"
  cidr          = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
}

data "template_file" "user_data" {
  template = file("${path.module}/web_bootstrap.tpl")
}

resource "aws_instance" "web" {
  ami                         = var.ami[var.region]
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = module.vpc_basic02.public_subnet_id
  private_ip                  = var.instance_ips[count.index]
  user_data                   = data.template_file.user_data.rendered
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.web_host_sg.id,
  ]

  tags = {
    Name = "web-${format("%03d", count.index + 1)}"
    // the first instance will be web-001, the scond web-002
  }

  count = length(var.instance_ips)
}

resource "aws_elb" "web" {
  name = "web-elb"
  subnets         = [module.vpc_basic02.public_subnet_id]
  security_groups = [aws_security_group.web_inbound_sg.id]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # The instances are registered automatically
  instances = aws_instance.web[*].id
}

resource "aws_security_group" "web_inbound_sg" {
  name        = "web_inbound"
  description = "Allow HTTP from Anywhere"
  vpc_id      = module.vpc_basic02.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_host_sg" {
  name        = "web_host"
  description = "Allow SSH & HTTP to web hosts"
  vpc_id      = module.vpc_basic02.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [module.vpc_basic02.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
