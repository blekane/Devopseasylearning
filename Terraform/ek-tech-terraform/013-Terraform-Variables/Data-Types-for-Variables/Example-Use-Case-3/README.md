### Code without variable
```tf
# Create a new load balancer
provider "aws" {
  region     = "us-east-1"
}

resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}
```

### Code with variable
```tf
# Create a new load balancer
provider "aws" {
  region     = "us-east-1"
}

resource "aws_elb" "bar" {
  name               = var.elb_name
  availability_zones = var.az

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = var.timeout
  connection_draining         = true
  connection_draining_timeout = var.timeout

  tags = {
    Name = "foobar-terraform-elb"
  }
}
```

### terraform.tfvars
```tf 
elb_name = "my-elb" 
timeout  = "400"
az       = ["us-west-2a", "us-west-2b", "us-west-2c"]
```

### variables.tf
```tf
variable "elb_name" {
  type = string
}

variable "az" {
  type = list # OR type = list(string)
}

variable "timeout" {
  type = number
}
```

### Variable file for elb
* [terraform-aws-modules/terraform-aws-elb](https://github.com/terraform-aws-modules/terraform-aws-elb)


```tf
variable "name" {
  description = "The name of the ELB"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix name of the ELB"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = list(string)
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  type        = bool
  default     = false
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining"
  type        = bool
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  type        = number
  default     = 300
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "listener" {
  description = "A list of listener blocks"
  type        = list(map(string))
}

variable "access_logs" {
  description = "An access logs block"
  type        = map(string)
  default     = {}
}

variable "health_check" {
  description = "A health check block"
  type        = map(string)
}

variable "number_of_instances" {
  description = "Number of instances to attach to ELB"
  type        = number
  default     = 0
}

variable "instances" {
  description = "List of instances ID to place in the ELB pool"
  type        = list(string)
  default     = []
}

variable "create_elb" {
  description = "Create the elb or not"
  type        = bool
  default     = true
}
```