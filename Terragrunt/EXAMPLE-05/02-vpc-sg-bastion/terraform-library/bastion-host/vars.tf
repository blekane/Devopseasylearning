variable "environment" {
  type = string
  default = "mam-prod"
}

variable "ami" {
  type = string
  default = "ami-04d29b6f966df1537"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "key_name" {
  type = string
  default = "jenkins-key"
}
