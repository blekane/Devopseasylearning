resource "aws_vpc" "tfb" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "tfb" {
  vpc_id = aws_vpc.tfb.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.tfb.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tfb.id
}

resource "aws_subnet" "public01" {
  vpc_id                  = aws_vpc.tfb.id
  cidr_block              = var.public_subnets[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.azs[0]
  tags = {
    Name = "${var.name}-public01"
  }
}

resource "aws_subnet" "public02" {
  vpc_id                  = aws_vpc.tfb.id
  cidr_block              = var.public_subnets[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.azs[1]
  tags = {
    Name = "${var.name}-public02"
  }
}

variable "azs" {
  type = list
  default = ["us-east-1a", "us-east-1b"]
}