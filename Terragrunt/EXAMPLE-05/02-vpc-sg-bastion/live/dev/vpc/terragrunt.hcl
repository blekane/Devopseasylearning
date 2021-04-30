
terraform {
  source = "../../../terraform-library/vpc/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
    name           = "mam-prod-vpc"
    cidr           = "10.0.0.0/16"
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

