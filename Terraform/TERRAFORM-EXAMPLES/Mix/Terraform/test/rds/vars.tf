variable "vpc_id" {
  type        = string
  description = "The ID of the VPC these resources should be added to."
}

variable "kms_arn" {
  type        = string
  description = "The ARN of the KMS key to use for encrypting AMIs and volumes."
  default     = null
}

variable "tags" {
  type = map(string)
}

variable "_tag_defaults" {
  description = "Default tags to add to all resources"
  type        = map(string)
  default = {
    terraform = "yes"
  }
}

variable "rds" {
  description = "The map of properties for rds to override defaults"
  type        = map(string)
  default     = {}
}

variable "_rds_defaults" {
  description = "Default rds properties, if not overridden"
  type        = map(string)
  default = {
    instance_class              = "db.m4.2xlarge"
    allocated_storage           = "250"
    max_allocated_storage       = "2" # multiplier for allocated_storage
    engine                      = "postgres"
    engine_version              = "9.6.18"
    license_model               = "postgresql-license"
    allow_major_version_upgrade = false
    port                        = "5432"
    apply_immediately           = false
    multi_az                    = false
    name                        = "lbrePostgres" # DB name
    maintenance_window          = "mon:07:32-mon:08:02"
    backup_window               = "06:23-06:53"
    backup_retention_period     = "7"
    username                    = "postgres"
    snapshot_identifier         = null
    storage_encrypted           = true
  }
}