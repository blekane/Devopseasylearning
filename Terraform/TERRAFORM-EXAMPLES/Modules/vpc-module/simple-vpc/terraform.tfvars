aws_region           = "us-east-1"
environment          = "prod"
name                 = "vpc_prod"
public_route         = "0.0.0.0/0"
vpc_cidr             = "20.10.0.0/16"
public_subnets_cidr  = ["20.10.1.0/24", "20.10.2.0/24"]
private_subnets_cidr = ["20.10.11.0/24", "20.10.12.0/24"]
db_subnets_cidr      = ["20.10.21.0/24", "20.10.22.0/24"]