
terraform {
  source = "../../../terraform-library/elb-sg/"
}

dependencies {
  paths = ["${get_terragrunt_dir()}/../vpc"]
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

