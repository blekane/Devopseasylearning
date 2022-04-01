
# User data
data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"
}

resource "aws_launch_configuration" "bastion" {
  # Launch Configurations cannot be updated after creation with the AWS API.
  # In order to update a Launch Configuration, Terraform will destroy the
  # existing resource and create a replacement.
  #
  # We're only setting the name_prefix here,
  # Terraform will add a random string at the end to keep it unique.
  name_prefix = "${var.tags.environment}-bastion-launch-configuration"

  image_id                    = "${var.ami}"
  instance_type               = "${var.bastion_instance_type}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
  enable_monitoring           = false
  security_groups             = ["${aws_security_group.bastion.id}"]

  user_data = "${data.template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "bastion" {
  # Force a redeployment when launch configuration changes.
  # This will reset the desired capacity if it was changed due to
  # autoscaling events.
  name = "${var.tags.environment}-bastion-asg"

  min_size             = 0
  desired_capacity     = 2
  max_size             = 2
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.elb.id]
  launch_configuration = "${aws_launch_configuration.bastion.name}"
  vpc_zone_identifier  = aws_subnet.public.*.id

  tags = [
    {
      key                 = "Name"
      value               = "${var.tags.environment}-bastion"
      propagate_at_launch = true
    },
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}

# Security group
resource "aws_security_group" "bastion" {
  name_prefix = "${var.tags.environment}-bastion-sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  tags = merge(map("Name", format("%s-bastion-security-group", var.tags["environment"])), var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "allow_all_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}


resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"

}

# Security group
resource "aws_security_group" "elb" {
  name_prefix = "${var.tags.environment}-elb-sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  tags = merge(map("Name", format("%s-elb-security-group", var.tags["environment"])), var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_http01" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "allow_all_outbound01" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"

}

### Creating ELB
resource "aws_elb" "elb" {
  name = "${var.tags.environment}-elb"

  tags = merge(map("Name", format("%s-elb", var.tags["environment"])), var.tags)

  security_groups = ["${aws_security_group.elb.id}"]
  subnets = aws_subnet.public.*.id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
   //cross_zone_load_balancing = true
   idle_timeout = 60
   connection_draining = true
   connection_draining_timeout = 1200
}
/* 
resource "aws_lb_cookie_stickiness_policy" "http-sticky-policy" {
  name = "${var.tags.environment}-http-sticky-policy"
  load_balancer            = aws_elb.elb.id
  lb_port                  = 80
  cookie_expiration_period = 1200 // 20 minites
}
*/