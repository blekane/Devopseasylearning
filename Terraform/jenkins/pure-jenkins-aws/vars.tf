variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type = map
  default = {
    us-east-1    = "ami-04d29b6f966df1537"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "key_name" {
  type    = string
  default = "jenkins-key"
}