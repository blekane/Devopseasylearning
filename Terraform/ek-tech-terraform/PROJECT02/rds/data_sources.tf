data "aws_subnet" "mam_dev_private_subnet_ap_southeast_2a" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-private-subnet-ap-southeast-2a"]
  }
}

data "aws_subnet" "mam_dev_private_subnet_ap_southeast_2b" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-private-subnet-ap-southeast-2b"]
  }
}

data "aws_subnet" "mam_dev_private_subnet_ap_southeast_2c" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-private-subnet-ap-southeast-2c"]
  }
}


data "aws_subnet" "mam_dev_public_subnet_ap_southeast_2a" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-public-subnet-ap-southeast-2a"]
  }
}

data "aws_subnet" "mam_dev_public_subnet_ap_southeast_2b" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-public-subnet-ap-southeast-2b"]
  }
}

data "aws_subnet" "mam_dev_public_subnet_ap_southeast_2c" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-public-subnet-ap-southeast-2c"]
  }
}

data "aws_vpc" "mam_dev_vpc" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-vpc"]
  }
}

