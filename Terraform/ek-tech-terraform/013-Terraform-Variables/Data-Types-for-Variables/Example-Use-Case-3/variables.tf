variable "elb_name" {
  type = string
}

variable "az" {
  type = list # or type = list(string)
}

variable "timeout" {
  type = number
}