provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "dev" {
  tags = {
    Name = "Tia-public"
  }
}

output "dev" {
  value = data.aws_vpc.dev.id
}

data "aws_vpc" "default_vpc" {
	default = true  
}

output "default_vpc" {
  value = data.aws_vpc.default_vpc.id
}
