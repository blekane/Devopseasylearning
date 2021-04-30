
terraform {
  //source = "github.com/leonardtia1/test-module/terraform/ec2"
  source            = "../../../terraform-library/vpc/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
    aws-region       = "us-east-1"
    vpc_cdir         = "192.168.0.0/16"
    cdir-bloc-subnet = ["192.168.0.0/24", "192.168.1.0/24"]
    azs              = ["us-east-1a", "us-east-1b"]
    external-route   = "0.0.0.0/0"
}