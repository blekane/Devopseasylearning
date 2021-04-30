/*
terraform {
  source = "../../../terraform-library/secrets/"
}

# Required for ordering blocks using apply-all, destroy-all etc
# RDS will be the first to be deleted and the last to be created while running apply-all, destroy-all
# Secrets will be created before RDS

dependencies {
  paths = [
    "${get_terragrunt_dir()}/../rds" 
    ]
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
*/