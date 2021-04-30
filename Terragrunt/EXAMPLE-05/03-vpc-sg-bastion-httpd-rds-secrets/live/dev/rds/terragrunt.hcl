terraform {
  source = "../../../terraform-library/rds/"
}

# Required for ordering blocks using apply-all, destroy-all etc
# RDS will be the first to be deleted and the last to be created while running apply-all, destroy-all
# All these dependencies will be created before RDS

dependencies {
  paths = [
    "${get_terragrunt_dir()}/../vpc", 
    "${get_terragrunt_dir()}/../bastion-sg", 
    "${get_terragrunt_dir()}/../elb-sg",
    "${get_terragrunt_dir()}/../web-sg",
    "${get_terragrunt_dir()}/../rds-sg",
    "${get_terragrunt_dir()}/../bastion-host",
    "${get_terragrunt_dir()}/../webserver-httpd"
    ]
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


inputs = {
    identifier        = "demodb"
    engine            = "mysql"
    engine_version    = "5.7.19"
    instance_class    = "db.t2.micro"
    storage_type      = "standard"
    allocated_storage = 5
    name              = "demodb"
    port              = 3306
}

