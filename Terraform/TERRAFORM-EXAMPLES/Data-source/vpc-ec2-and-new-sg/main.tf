provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "dev" {
  filter {
    name = "tag:Name"
    values = ["Tia-public"]
  }
}

output "dev" {
  value = data.aws_vpc.dev.id
}


data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Public subnet"] # insert value here
  }
}

output "selected" {
  value = data.aws_subnet.selected
}



