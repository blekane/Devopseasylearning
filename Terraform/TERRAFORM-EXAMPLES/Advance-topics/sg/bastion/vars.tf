variable "name" {
  description = "Name, will be appended to the `environment` tag to name the resources. Should be something like `app`, `db`, `alb`, etc."
  default = "bastion"
}

variable "revoke_rules" {
  type        = bool
  description = "Revoke attached rules prior to Security Group deletion"
  default     = true
}

variable "tags" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    environment = "mam-dev"
    terraform   = "yes"
    project     = "mam"
  }
}

variable "_tag_defaults" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    terraform = "yes"
  }
}

