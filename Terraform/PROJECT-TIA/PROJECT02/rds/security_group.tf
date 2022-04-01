# Security group
resource "aws_security_group" "default" {
  name        = "${var.tags.environment}-rds-sg"
  description = "Allow Postgres traffic"
  vpc_id      = data.aws_vpc.mam_dev_vpc.id

  tags = merge(map("Name", format("%s-rds-security-group", var.tags["environment"])), var.tags)
}


resource "aws_security_group_rule" "allow_ingress" {
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  security_group_id = "${aws_security_group.default.id}"
  
  cidr_blocks = [
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2a.cidr_block,
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2b.cidr_block,
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2c.cidr_block
  ]

}

resource "aws_security_group_rule" "allow_egress" {
  type        = "egress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = [
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2a.cidr_block,
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2b.cidr_block,
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2c.cidr_block
  ]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "allow_all" {
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.default.id}"
}
