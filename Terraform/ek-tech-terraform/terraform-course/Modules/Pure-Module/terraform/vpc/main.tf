### Create a VPC (Virtual Private Cloud in AWS)!
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cdir
  enable_dns_hostnames = true
  tags = {
    Name = "Dev VPC"
  }
}


### Create a Public Subnet with auto public IP Assignment enabled in dev_vpc VPC!
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.cdir-bloc-subnet[0]
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Dev VPC Public Subnet"
  }
}


### Create a Private Subnet in customer VPC!
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.cdir-bloc-subnet[1]
  availability_zone = var.azs[1]
  
  tags = {
    Name = "Dev VPC Private Subnet"
  }
}


### Creating an Internet Gateway!
resource "aws_internet_gateway" "Internet_Gateway" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "Dev VPC IGW"
  }
}


### Create a routing table for Internet Gateway!
resource "aws_route_table" "Public-Subnet-RT" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = var.external-route
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Dev VPC Route Table for Internet Gateway"
  }
}


### Associate the routing table to the Public Subnet!
resource "aws_route_table_association" "RT-IG-Association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.Public-Subnet-RT.id
}


### Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "Nat-Gateway-EIP" {
  vpc = true
}

### Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id = aws_subnet.subnet1.id
  tags = {
    Name = "Dev VPC Nat Gateway"
  }
}


### Creating a Route Table for the NAT Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = var.external-route
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Dev VPC Route Table for NAT Gateway"
  }

}


### Associating the Route table for NAT Gateway to Public Subnet!
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}


