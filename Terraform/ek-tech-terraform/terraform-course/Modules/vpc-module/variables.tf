variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "environment" {
    type = string
    default = "prod"
}

variable "name" {
    type = string
    default = "vpc_prod"
}

variable "vpc_cidr" {
    type = string
    default = "20.10.0.0/16"
}

variable "public_route" {
    type = string
    default = "0.0.0.0/0"
}

variable "public_subnets_cidr" {
    type    = list
    default = ["20.10.1.0/24", "20.10.2.0/24"]
}

variable "private_subnets_cidr" {
    type    = list
    default = ["20.10.11.0/24", "20.10.12.0/24"]
}

variable "db_subnets_cidr" {
     type    = list 
     default = ["20.10.21.0/24", "20.10.22.0/24"]
}


