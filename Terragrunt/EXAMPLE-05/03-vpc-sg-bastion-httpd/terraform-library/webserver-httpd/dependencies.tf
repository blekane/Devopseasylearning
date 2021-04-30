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

data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")
}
