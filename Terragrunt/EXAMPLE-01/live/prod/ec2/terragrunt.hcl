
terraform {
  //source = "github.com/leonardtia1/test-module/terraform/ec2"
  source            = "../../../terraform-library/ec2/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
    aws-region        = "us-east-1"
    availability_zone = "us-east-1a"
    ami               = "ami-04bf6dcdc9ab498ca"
    key_name          = "jenkins-key"
    instance_type     = "t2.micro"
}