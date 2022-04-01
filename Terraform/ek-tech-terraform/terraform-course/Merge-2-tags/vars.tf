variable "tags" {
  type = map(string)
}

variable "_tag_defaults" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    terraform   = "yes"
    environment = "mam-dev"
  }
}