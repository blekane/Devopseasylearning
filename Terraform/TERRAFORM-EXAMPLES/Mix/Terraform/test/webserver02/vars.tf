variable "ec2" {
  description = "The map of properties for ec2 to override defaults"
  type        = map(string)
  default = {
    ami               = "ami-04d29b6f966df1537"
    instance_type     = "t2.micro"
    key_name          = "jenkins-key"
  }
}

variable "azs" {
  type = list
  default = ["us-east-1c", "us-east-1d"]
}


variable "environment" {
  type = string
  default = "mam-prod"
}