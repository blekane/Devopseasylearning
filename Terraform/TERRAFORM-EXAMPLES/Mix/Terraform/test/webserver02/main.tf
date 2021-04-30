
provider "aws" {
  region = "us-east-1"
}


data "aws_security_group" "mam_prod_web_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-web-sg"]
  }
}

data "aws_subnet" "mam_prod_vpc_public01" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc-public01"]
  }
}
/*
data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")
}
*/
data "aws_security_group" "mam_prod_elb_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-elb-sg"]
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1c"
  tags = {
	"Terraform" = "True"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1d"
  tags = {
	"Terraform" = "True"
  }
}

resource "aws_elb" "mam_prod_elb" {
	name              = "${var.environment}-elb"
	// * here is to use all instances
	//instances          = aws_autoscaling_group.man_prod_autoscaling[*]
  	//instances        = aws_instance.prod_web.*.
  //availability_zones = ["us-east-1c", "us-east-1c"]
	subnets            = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
	security_groups    = [data.aws_security_group.mam_prod_elb_sg.id]

	listener {
	  instance_port     = 80
	  instance_protocol = "http"
	  lb_port           = 80
	  lb_protocol       = "http"
	}

	  tags = {
	"Terraform" = "True"
  }
}

resource "aws_launch_template" "mam_launch_template" {
	name_prefix       = "${var.environment}-launch-template"
  image_id          = var.ec2["ami"]
	instance_type     = var.ec2["instance_type"]
  key_name          = var.ec2["key_name"]
  //user_data         = data.template_file.user_data.rendered
  //security_groups   = [data.aws_security_group.mam_prod_web_sg.id]
  //subnet_id         = data.aws_subnet.mam_prod_vpc_public01.id
  user_data = <<-EOF
                #!/bin/bash
                # user data
                yum update -y
                amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                yum install -y httpd mariadb-server
                systemctl start httpd
                systemctl enable httpd

                # php script
                cd /var/www/html/
                wget https://linux-devops-course.s3.amazonaws.com/AWS+Demo/web+content/index.php
                EOF
	tags = {
		Name = "${var.environment}-apache-httpd"
	}
}


resource "aws_autoscaling_group" "man_prod_autoscaling" {
  //availability_zones  = ["us-east-1c", "us-east-1d"]
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  
  launch_template {
    id      = aws_launch_template.mam_launch_template.id
    version = "$Latest"
  }
  tag {
    key                 = "Terraform"
    value               = "${var.environment}-launch-template"
    propagate_at_launch = true
  }
}


// This is to attach auto-scalling to ELB
resource "aws_autoscaling_attachment" "mam_prod_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.man_prod_autoscaling.id
  elb                    = aws_elb.mam_prod_elb.id
}
