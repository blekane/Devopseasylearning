variable "region" {
  type = "string"
}

variable "db_name" {
  type = "string"
}

variable "username" {
  type = "string"
}

variable "instance_class" {
  type = "string"
}

variable "tags" {
  type = map(string)
  default = {
      owner         = "norm.nadeau@tcs.com" 
      project       = "mam" 
      environment   = "mam-dev" 
  }
}