### Code without viraible
```tf
resource "aws_security_group" "var_demo" {
  name        = "kplabs-variables"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["116.30.45/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["116.30.45/32"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["116.30.45/32"]
  }
}
```

### Code with viraible 
* Create a variable file first variables.tf
```tf
variable "vpn_ip" {
  default = "116.50.30.50/32"
}
```
* Refer the variable in SG.tf file
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "var_demo" {
  name        = "kplabs-variables"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
}
```