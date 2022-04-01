variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

variable "availability_zones" {
  type = list(string)
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "owner" {
  type = string
}

## VPC Variables
variable "vpc_cidr_block" {
  type        = string
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "enable_dns_support" {
  type = string
}

variable "enable_dns_hostnames" {
  type = string
}

variable "enable_classiclink" {
  type = string
}

variable "map_public_ip_on_launch" {
  type = string
}


# ## Bastion Variables
# variable "bastion_instance_type" {
#   description = "EC2 Instnace Type for bastion"
#   type        = string
# }

# variable "instance_keypair" {
#   description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
#   type        = string
# }

# variable "monitoring" {
#   type = string
# }

# ## Test EC2 Variables
# variable "test_ec2_instance_count" {
#   type = string
# }

# variable "test_ec2_instance_type" {
#   type = string
# }


# ## DB Variables
# variable "engine" {
#   type = string
# }

# variable "engine_version" {
#   type = string
# }

# variable "instance_class" {
#   type = string
# }

# variable "allocated_storage" {
#   type = string
# }

# variable "max_allocated_storage" {
#   type = string
# }

# variable "name" {
#   type = string
# }

# variable "username" {
#   type = string
# }

# variable "password" {
#   type = string
# }

# variable "storage_encrypted" {
#   type = string
# }

# variable "storage_type" {
#   type = string
# }

# variable "port" {
#   type = string
# }

# variable "multi_az" {
#   type = string
# }

# variable "maintenance_window" {
#   type = string
# }

# variable "backup_window" {
#   type = string
# }

# variable "backup_retention_period" {
#   type = string
# }

# variable "apply_immediately" {
#   type = string
# }

# variable "skip_final_snapshot" {
#   type = string
# }

# variable "deletion_protection" {
#   type = string
# }

# variable "publicly_accessible" {
#   type = string
# }





