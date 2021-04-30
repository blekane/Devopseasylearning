
terraform {
  source = "../../../terraform-library/bastion-host/"
}

# Required for ordering blocks using apply-all, destroy-all etc
dependencies {
  paths = [
    "${get_terragrunt_dir()}/../vpc", 
    "${get_terragrunt_dir()}/../bastion-sg", 
    "${get_terragrunt_dir()}/../elb-sg",
    "${get_terragrunt_dir()}/../web-sg",
    "${get_terragrunt_dir()}/../rds-sg"
    ]
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


inputs = {
    ami               = "ami-04d29b6f966df1537"
    instance_type     = "t2.micro"
    availability_zone = "us-east-1a"
    key_name          = "jenkins-key"
}
