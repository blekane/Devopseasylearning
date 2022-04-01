######################################################
# Main VPC                                           
######################################################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink

  tags = {
    Name        = format("%s-vpc", var.environment)
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}



######################################################
# Enable access to or from the Internet for instances
# in public subnets
######################################################
resource "aws_internet_gateway" "main" {
  depends_on = [
    aws_vpc.main
  ]

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = format("%s-internet-vpc-gateway", var.environment)
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}


######################################################
# Public subnets
# Each subnet in a different AZ
######################################################

resource "aws_subnet" "public" {
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.main
  ]

  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-vpc-public-subnet-${element(var.availability_zones, count.index)}"
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}


######################################################
# Private subnets
# Each subnet in a different AZ
######################################################
resource "aws_subnet" "private" {
  depends_on = [
    aws_vpc.main
  ]

  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + length(var.availability_zones))
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name        = "${var.environment}-vpc-private-subnet-${element(var.availability_zones, count.index)}"
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}


######################################################
# NAT gateways  enable instances in a private subnet
# to connect to the Internet or other AWS services,
# but prevent the internet from initiating
# a connection with those instances.
#
# We create a separate NAT gateway in each AZ
# for high availability.
#
# Each NAT gateway requires an Elastic IP.
######################################################
resource "aws_eip" "nat" {
  count = length(var.availability_zones)
  vpc   = true
  tags = {
    Name        = "${var.environment}-eip-${element(var.availability_zones, count.index)}"
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}

resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.nat.*.id, count.index)

  tags = {
    Name        = "${var.environment}-vpc-nat-${element(var.availability_zones, count.index)}"
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}


######################################################
# Route the public subnet traffic through
# the Internet Gateway
######################################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = format("%s-vpc-public-route-table", var.environment)
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


######################################################
# Create a new route table for private subnets
# Route non-local traffic through the NAT gateway
# to the Internet
######################################################
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-vpc-private-route-table-${element(var.availability_zones, count.index)}"
    Environment = var.environment
    Owner       = var.owner
    "Manage by" : "Terraform"
  }
}

resource "aws_route" "nat_gateway" {
  count = length(var.availability_zones)

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
