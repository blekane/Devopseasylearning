provider "aws" {
  region = "us-west-2"
}

# Query all avilable Availibility Zone
data "aws_availability_zones" "available" {}
/*
us-west-2a ----->> index[0]
us-west-2b ----->> index[1]
us-west-2c ----->> index[2]
us-west-2d ----->> index[3]
*/

# VPC Creation

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "my-new-test-terraform-vpc"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "my-test-igw"
  }
}

# Create EIP

resource "aws_eip" "my-test-eip" {
  vpc = true
}


# Create a NAT and associate it with the EIP

resource "aws_nat_gateway" "my-test-nat-gateway" {
  allocation_id = "${aws_eip.my-test-eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.0.id}"
  //subnet_id     = aws_subnet.public_subnet.0.id
  //subnet_id     = aws_subnet.public_subnet[0].id
}

# Public Route Table

resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "my-test-public-route"
  }
}

# Private Route Table

resource "aws_default_route_table" "private_route" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  route {
    nat_gateway_id = "${aws_nat_gateway.my-test-nat-gateway.id}"
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "my-private-route-table"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  // count is 2 for 2 public_subnet in 2 AZs us-west-2a and us-west-2b
  count                   = 2

  /*
  var.public_cidrs[0] for first value and var.public_cidrs[1] for second value
  us-west-2a ----->> index[0]
  us-west-2b ----->> index[1]
  us-west-2c ----->> index[2]
  us-west-2d ----->> index[3]
  */

  cidr_block              = "${var.public_cidrs[count.index]}"
  vpc_id                  = "${aws_vpc.main.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

/*
  // var.azs[0] for first value and var.azs[1] for second value
  availability_zone       = var.azs[count.index]
*/

  tags = {
    Name = "my-test-public-subnet.${count.index + 1}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  count             = 2
  cidr_block        = "${var.private_cidrs[count.index]}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "my-test-private-subnet.${count.index + 1}"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  // we need to associate 2 subnets
  count          = 2
  route_table_id = "${aws_route_table.public_route.id}"
  
  /*
   .*. meant all the subnets in the list. We have 2 here
   the firs will be at index[0] and the second at index[1]
   default = ["10.0.1.0/24", "10.0.2.0/24"]

   subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
   OR
   subnet_id      = "${aws_subnet.public_subnet[*].id[count.index]}"
  */

  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
  // the subnet association will depend on these 2 value
  depends_on     = ["aws_route_table.public_route", "aws_subnet.public_subnet"]
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = 2
  route_table_id = "${aws_default_route_table.private_route.id}"
  subnet_id      = "${aws_subnet.private_subnet.*.id[count.index]}"
  depends_on     = ["aws_default_route_table.private_route", "aws_subnet.private_subnet"]
}

# Security Group Creation
resource "aws_security_group" "test_sg" {
  name   = "my-test-sg"
  vpc_id = "${aws_vpc.main.id}"
}

# Ingress Security Port 22
resource "aws_security_group_rule" "ssh_inbound_access" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.test_sg.id}"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_inbound_access" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.test_sg.id}"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# All OutBound Access
resource "aws_security_group_rule" "all_outbound_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.test_sg.id}"
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}



