
terraform {
  source = "../../../terraform-library/rds-sg/"
}

dependencies {
  paths = ["${get_terragrunt_dir()}/../vpc", "${get_terragrunt_dir()}/../bastion-sg", "${get_terragrunt_dir()}/../web-sg"]
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

