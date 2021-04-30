provider "aws" {
    region = "us-east-1"
}

resource "aws_eip" "myeip" {
   vpc      = true
}


resource "aws_security_group" "allow_all" {
  name        = "interpolation-demo"


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${aws_eip.myeip.public_ip}/32"]
  }
}
