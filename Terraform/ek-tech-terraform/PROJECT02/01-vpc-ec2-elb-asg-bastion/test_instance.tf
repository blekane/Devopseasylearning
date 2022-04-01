resource "aws_launch_configuration" "test" {
#Launch Configurations cannot be updated after creation with the AWS API.
#In order to update a Launch Configuration, Terraform will destroy the existing resource and create a replacement.
#We're only setting the name_prefix here,
#Terraform will add a random string at the end to keep it unique.


  name_prefix = "${var.tags.environment}-test-launch-configuration"

  image_id                    = "${var.ami}"
  instance_type               = "${var.bastion_instance_type}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = false
  enable_monitoring           = false
  security_groups             = ["${aws_security_group.test.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "test" {
  name              = "${var.tags.environment}-test-asg"
  min_size          = 0
  desired_capacity  = 1
  max_size          = 1
  health_check_type = "EC2"

  launch_configuration = "${aws_launch_configuration.test.name}"

  vpc_zone_identifier = aws_subnet.private.*.id

  tags = [
    {
      key                 = "Name"
      value               = "${var.tags.environment}-test"
      propagate_at_launch = true
    },
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}


# Security group
resource "aws_security_group" "test" {
  name_prefix = "test SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  tags = merge(map("Name", format("%s-test-security-group", var.tags["environment"])), var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_ssh_test" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = aws_subnet.public.*.cidr_block
  security_group_id = "${aws_security_group.test.id}"
  # This will allow port 22 from all public subnet
  #22	TCP	10.0.0.0/24	test SG20201228111157245100000001
  #22	TCP	10.0.1.0/24	test SG20201228111157245100000001
  #22	TCP	10.0.2.0/24	test SG20201228111157245100000001
  #8 - 0	ICMP	0.0.0.0/0	test SG20201228111157245100000001

}

resource "aws_security_group_rule" "allow_all_outbound_test" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.test.id}"
}

resource "aws_security_group_rule" "allow_ping" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.test.id}"
}
