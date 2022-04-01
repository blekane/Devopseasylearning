### create users
```tf
provider "aws" {
  region = "us-east-1"
}

variable "users" {
  type    = list(string)
  default = ["bob", "paul", "jhon"]
}

resource "aws_iam_user" "users" {
  for_each = toset(var.users)
  name     = each.value
  //name     = each.key
}
```

### Create a SG
```tf
provider "aws" {
  region = "us-east-1"
}


locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key
  security_groups = [ aws_security_group.web_traffict.name ]

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}


variable "ingress_rules" {
  type = list(number)
  default = [22, 80, 8080, 3306, 443, 23]
}

variable "egress_rules" {
  type = list(number)
  default = [22, 80, 8080, 3306, 443, 23]
}


resource "aws_security_group" "web_traffict" {
  name = "Secure Server"
  dynamic "ingress" {
      iterator = port
      for_each = var.ingress_rules
      content {
          from_port   = port.value
          to_port     = port.value
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

    dynamic "egress" {
      iterator = port
      for_each = var.egress_rules
      content {
          from_port   = port.value
          to_port     = port.value
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
}
```

### SG 
```TF
provider "aws" {
  region = "us-east-1"
}


variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443, 22]
}

variable "egress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [0]
}


resource "aws_vpc" "test" {
  cidr_block = "172.16.0.0/16"
  tags = {
    "Name" = "dev-vpc"
  }
}

resource "aws_security_group" "test" {
  name = "Web-sg"
  vpc_id = aws_vpc.test.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### SG
```tf
provider "aws" {
  region = "us-east-1"
}


locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key
  security_groups = [ aws_security_group.web_traffict.name ]

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}


variable "ingress_rules" {
  type = list(number)
  description = "list of ingress ports"
  default = [22, 80, 8080, 3306, 443, 23]
}

variable "egress_rules" {
  description = "list of egress ports"
  type = list(number)
  default = [0]
}


resource "aws_security_group" "web_traffict" {
  name = "Secure Server"
  dynamic "ingress" {
      iterator = port
      for_each = var.ingress_rules
      content {
          from_port   = port.value
          to_port     = port.value
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

    dynamic "egress" {
      iterator = port
      for_each = var.egress_rules
      content {
          from_port   = port.value
          to_port     = port.value
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
}
```






