module "sg-rds" {
  source = "git::https://git@bitbucket.pearson.com/gops-tf/gops_tf_security_group.git//?ref=0.1.2"

  name   = "rds"
  tags   = local.tags
  vpc_id = var.vpc_id
}

# INGRESS #

resource "aws_security_group_rule" "rds-5432-webapp" {
  security_group_id        = module.sg-rds.security_group.id
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = data.aws_security_group.webapp.id
}

resource "aws_security_group_rule" "rds-5432-bastion" {
  security_group_id        = module.sg-rds.security_group.id
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = data.aws_security_group.bastion.id
}

# EGRESS #

resource "aws_security_group_rule" "rds-egress-ephemeral" {
  security_group_id = module.sg-rds.security_group.id
  type              = "egress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}