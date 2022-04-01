variable "tags" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    terraform   = "yes"
    project     = "mam"
  }
}