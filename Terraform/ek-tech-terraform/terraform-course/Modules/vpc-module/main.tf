provider "aws" {
    region = var.aws_region
}

module "vpc1" {
    source = "./vpc"
    aws_region           = var.aws_region
    environment          = var.environment
    name                 = var.name
    public_route         = var.public_route
    vpc_cidr             = var.vpc_cidr
    public_subnets_cidr  = var.public_subnets_cidr
    private_subnets_cidr = var.private_subnets_cidr
    db_subnets_cidr      = var.db_subnets_cidr  
}


module "vpc2" {
    source = "./vpc"
    aws_region           = "us-east-2"
    environment          = "dev"
    name                 = "vpc_dev"
    public_route         = "0.0.0.0/0"
    vpc_cidr             = "10.0.0.0/16"
    public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
    db_subnets_cidr      = ["10.0.5.0/24", "10.0.6.0/24"]  
}