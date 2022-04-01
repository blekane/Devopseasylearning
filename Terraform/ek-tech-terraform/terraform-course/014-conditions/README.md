### condition
* if the variable value is equal to prod, create the resource. if it not equal to prod, do not create a resource.
```tf
provider "aws" {
  region = "us-east-1"
}

variable "ec2" {
  description = "Create ec2 for Dev"
  type = string
  default = "prod"
}

locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  count         = var.ec2 == "prod" ? 1 : 0 
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}
```

### condition
* if the variable is not equal to 0, create 3 ec2 instances. 
* else if the variable is equal to 0, create at least 1 ec2
* `Plan: 3 to add, 0 to change, 0 to destroy.`

```tf
provider "aws" {
  region = "us-east-1"
}

variable "ec2" {
  description = "Create ec2 for Dev"
  type = number
  default = 3
}

locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  count         = var.ec2 != 0 ? var.ec2 :  1
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}
```

### condition
* if the variable is equal to 1, create 1 ec2 instance. 
* else, create at least 5 ec2
* `Plan: 1 to add, 0 to change, 0 to destroy`.
`
```tf
provider "aws" {
  region = "us-east-1"
}

variable "ec2" {
  description = "Create ec2 for Dev"
  type = number
  default = 1
}

locals {
  instance_name = "dev-instance"
  instance_type = "t2.micro"
  instance_key  = "jenkins-key"
  instance_ami  = "ami-04d29b6f966df1537"
}

resource "aws_instance" "myec3" {
  count         = var.ec2 == 1 ? var.ec2 :  5
  ami           = local.instance_ami
  instance_type = local.instance_type
  key_name      = local.instance_key

  tags = {
    "Name" = "${local.instance_name}-tia"
    "Env"  = "Dev"
  }
}
```