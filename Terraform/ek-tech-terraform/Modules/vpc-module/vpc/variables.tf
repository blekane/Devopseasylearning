variable "aws_region" {
    type = string
}

variable "environment" {
    type = string
}

variable "name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "public_route" {
    type = string
}

variable "public_subnets_cidr" {
    type    = list
}

variable "private_subnets_cidr" {
    type    = list
}

variable "db_subnets_cidr" {
     type    = list 
}