variable "rds_password" {
  type        = string
  description = "Master DB password for RDS."
}

variable "rds_username" {
  type        = string
  description = "Master DB Username for RDS."
}

variable "tags" {
  type = map(string)
  default = {
      environment = "prod-mam"
  }
}
