/*
variable "rds_password" {
  type        = string
  description = "Master DB password for RDS. Should not be placed in source code. Either use terraform.tfvars or enter when running Terraform."
  default     = "DefaultPassword!23"
  //                Note that this value will be stored in the tfstate, but that bucket is only availbale to PowerUsers in the account.
  //                This value is also placed in Secrets Manager so it can retrieved later if forgotten."
}

variable "tags" {
  type = map(string)
  default = {
      environment = "dev"
  }
}
*/