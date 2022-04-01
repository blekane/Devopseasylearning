variable "aws-region" {
    type = string
}

variable "instancetype" {
    type = list
}

variable "cdir-bloc-subnet" {
    type = list
}

variable "azs" {
    type = list
}

variable "ssh-port" {
    type = number
}

variable "mysql-port" {
    type = number
}

variable "httpd-port" {
    type = number
}

variable "ami-key-pair" {
    type = list
}

variable "external-route" {
    type = string
}

variable "private-key-path" {
    type = string
}

variable "user" {
    type = string
}
