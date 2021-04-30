data "aws_vpc" "mam_prod" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc"]
  }
}

data "aws_security_group" "mam_prod_elb_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-elb-sg"]
  }
}

data "aws_security_group" "mam-prod-bastion-sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-bastion-sg"]
  }
}
