provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = var.instancetype
}