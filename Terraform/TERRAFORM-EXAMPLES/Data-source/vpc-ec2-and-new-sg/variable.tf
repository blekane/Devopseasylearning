

variable "ec2" {
  description = "The map of properties for ec2 to override defaults"
  type        = map(string)
  default = {
    ami               = "ami-04d29b6f966df1537"
    instance_type     = "t2.micro"
    count             = "1"
    availability_zone = "us-east-1c"
    key_name          = "jenkins-key"
  }
}
