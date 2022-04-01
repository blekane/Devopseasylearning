data "aws_vpc" "dev_vpc" {
  filter {
    name = "tag:Name"
    values = ["Dev VPC"]
  }
}


data "aws_subnet" "subnet_dev_vpc_public" {
  filter {
    name   = "tag:Name"
    values = ["Dev VPC Public Subnet"] 
  }
}

