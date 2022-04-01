
variable "aws_region" {
    type    = string
    default = "us-east-1"
}

variable "aws_amis" {
    type = map(string)

    default = {
        us-east-1 = "ami-04d29b6f966df1537"
        us-west-1 = "ami-08d9a394ac1c2994c"
        us-east-2 = "ami-09558250a3419e7d0"
    }
}

