data "aws_security_group" "mam_prod_bastion_sg" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-bastion-sg"]
  }
}

data "aws_subnet" "mam_prod_vpc_public01" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc-public01"]
  }
}
