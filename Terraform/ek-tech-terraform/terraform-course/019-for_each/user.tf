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