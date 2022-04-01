variable "ec2_string_var" {
  description = "The map of properties for ec2 to override defaults"
  type        = map(string)
  default = {
    ami               = "ami-04d29b6f966df1537"
    count             = "2"
    key_name          = "jenkins-key"
  }
}

variable "ec2_list_var" {
  description = "The map of properties for ec2 to override defaults"
  type        = map(list(string))
  default = {
  instance_type     = ["t2.micro", "t2.nano", "m4.large"]
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  }
}