
data "aws_vpc" "mam_prod" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc"]
  }
}

data "aws_security_group" "mam_prod_web_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-web-sg"]
  }
}

data "aws_security_group" "mam-prod-bastion-sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-bastion-sg"]
  }
}
