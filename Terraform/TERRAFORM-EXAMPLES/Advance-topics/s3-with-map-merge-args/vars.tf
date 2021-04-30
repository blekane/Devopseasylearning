variable "tags" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    environment   = "mam-dev"
    terraform     = "yes"
    project       = "mam"
    project-id    = "82540"
  }
}

