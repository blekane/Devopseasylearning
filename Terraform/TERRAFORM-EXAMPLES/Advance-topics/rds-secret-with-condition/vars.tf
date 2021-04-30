variable "rds_password" {
  type        = string
  description = "Master DB password for RDS. Should not be placed in source code. Either use terraform.tfvars or enter when running Terraform."
  default     = "DefaultPassword!23"
}


variable "tags" {
  type = map(string)
  default = {}
}

variable "_tag_defaults" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    terraform = "yes"
    environment = "mam-dev"
  }
}
