resource "aws_security_group" "bastion_group" {
  #mam-dev-bastion
  name                   = format("%s-%s", var.tags["environment"], var.name)
  
  # Security Group for mam-dev-bastion
  description            = "Security Group for ${format("%s-%s", var.tags["environment"], var.name)}"

  tags = merge(map("Name", format("%s-%s", var.tags["environment"], var.name)), local.tags)
  /*
Key             Value
project	        mam
environment	    mam-dev
terraform	    yes
Name	        mam-dev-bastion
*/
}


# Please note EGRESS only rules here. No SSH is allowed into the Bastion. It must be accessed via SSM.

# EGRESS #

resource "aws_security_group_rule" "bastion-egress-22" {
  security_group_id = aws_security_group.bastion_group.id
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress-80" {
  security_group_id = aws_security_group.bastion_group.id
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress-123" {
  security_group_id = aws_security_group.bastion_group.id
  type              = "egress"
  from_port         = 123
  to_port           = 123
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress-443" {
  security_group_id = aws_security_group.bastion_group.id
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress-ephemeral" {
  security_group_id = aws_security_group.bastion_group.id
  type              = "egress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}