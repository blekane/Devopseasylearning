resource "aws_security_group" "elb_security_group" {
  #mam-dev-bastion
  name              = format("%s-elb-security-group", var.tags["environment"])

  # Security Group for mam-dev-bastion
  description            = "Security Group for ${format("%s-elb", var.tags["environment"])}"

  tags = merge(map("Name", format("%s-elb-security-group", var.tags["environment"])), var.tags)

}


# INGRESS #

resource "aws_security_group_rule" "alb-443" {
  security_group_id = aws_security_group.elb_security_group.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb-8080" {
  security_group_id = aws_security_group.elb_security_group.id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Just for testing 
resource "aws_security_group_rule" "alb-3306" {
  security_group_id = aws_security_group.elb_security_group.id
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = data.aws_security_group.bastion_id.id
}

# EGRESS #

resource "aws_security_group_rule" "alb-egress-all" {
  security_group_id        = aws_security_group.elb_security_group.id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
}
/*
resource "aws_security_group_rule" "alb-egress-443" {
  security_group_id        = aws_security_group.elb_group.id
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elb_group.id
}

resource "aws_security_group_rule" "alb-egress-ephemeral" {
  security_group_id        = aws_security_group.elb_group.id
  type                     = "egress"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = module.sg-webapp.security_group.id
}
*/