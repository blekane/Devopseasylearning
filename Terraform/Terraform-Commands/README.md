
## Terraform Commannd


### .gitignore file
```
*.terraform
*.pem
*.tfvars
*.tfplan
*.tfstate
*.tfstate.backup
*.lock.info
.terraform
.DS_Store
```

### Download provider plugins to interact with the API
```
terraform init
```

### To see all the changes before applying with terraform apply command
```
terraform plan
```

### Create resources
```
terraform apply
```

### To skip yes while running terraform appply command
```
terraform apply --auto-approve
```

### To skip yes while running terraform destroy command
```
terraform destroy --auto-approve
```

### To see all Common commands in terraform
```
terraform
```
### Check all state Subcommands
```
terraform state
```

### List resources in the state
```
terraform state list
```

### List all resources in the state file or see the contents of your tfstate files
```
terraform state show 
```

### List a specific resource in the state
```
terraform state show <resource name>
terraform state show aws_internet_gateway.igw
```

### Command for Formatting
```
terraform fmt
```

## Commands used for State Management 
```
terraform state list
terraform state mv aws_instance.webapp aws_instance.myec2
terraform state rm aws_instance.myec2
```

### Command for Validating
```
terraform validate
```

### Delete all resources create by terraform
* This will destroy all the resource this the Terraform state fiel
* if you want to destroy a particular resource, you can either command that resource in the state file and run Terraform apply or you can use `terraform destroy --target <resource name>` to do that.
* This command `terraform destroy --target <resource name>` will remove the resource in the state file and if your `terraform apply again`, it will create the resource again.
* The best way to destroy the resource is to remove it in `.tf` file or to command it in `.tf` file and run terraform apply command.

```
terraform destroy
```

### To destroy a particular resource
```
terraform destroy --target <resource name>
terraform destroy --target aws_security_group.allow-web
```
### Lifecycle with destroy

* if lifecycle is set to `true` for any resources in terraform, it will not be deleted while running terraform destroy. 
* it most be set to `false` before you can destroy it.
* This just prevent someone from deleting the resource on the console because if we comment the resource or remove it from the configuration file and run `terraform destroy`, it will still destroy it.

```tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "name" {
  vpc      = true
  lifecycle {
    prevent_destroy = "true"
  }
}
```

```tf
provider "aws" {
  region = "us-east-1"
}

/*
resource "aws_eip" "name" {
  vpc      = true
  lifecycle {
    prevent_destroy = "true"
  }
}
*/
```
OR

```tf
provider "aws" {
  region = "us-east-1"
}
```

### Comment in terraform
We use /* and */ to comment in terrform

```
/*
This is a comment in terraform
*/
```

```tf
provider "aws" {
    profile = "default"
    region = "us-east-1"
}
/*
resource "aws_s3_bucket" "terraform_s3" {
    bucket = "terraform-bucket-232"
    acl = "private"
}
*/
```

### Refresh Command (to refresh the current state)
When we run terraform apply command, it refreshes the state file first to match the disered state to the current state. We can also run the `terraform refresh` command to refresh the state file.
```
terraform refresh
```

### The terraform workspace list command is used to list all existing workspaces.
* The command will list all existing workspaces. The current workspace is indicated using an asterisk (*) marker.
```
terraform workspace list
```

### The terraform workspace select command is used to choose a different workspace to use for further operations.
```
terraform workspace select [NAME]
terraform workspace select default
Switched to workspace "default".
```

### The terraform workspace new command is used to create a new workspace
```
terraform workspace new [NAME]
terraform workspace new example
Created and switched to workspace "example"!
```

### The terraform workspace delete command is used to delete an existing workspace.
* -force - Delete the workspace even if its state is not empty. Defaults to false.
```
terraform workspace delete [NAME]
terraform workspace delete example
Deleted workspace "example".
```

### The terraform workspace show command is used to output the current workspace.
* The command will display the current workspace.
```tf
terraform workspace show
```

### Assign variable while runing terraform apply
```
terraform plan -var="instancetype=t2.small"
```

### To deploy resources in the dev environment while using workspace.
```
terraform apply -var-file=dev.tfvars
OR 
terraform apply -var-file=dev.tfvars
```

### To deploy resources in the prod environment while using workspace
```
terraform apply -var-file=prod.tfvars
OR
terraform apply -var-file prod.tfvars
```

### To destroy resources in the prod environment while using workspace
```
terraform destroy -var-file=prod.tfvars
OR
terraform destroy -var-file prod.tfvars
```

### To destroy resources in the dev environment while using workspace
```
terraform destroy -var-file=dev.tfvars
OR
terraform destroy -var-file dev.tfvars
```

### To plan resources in the dev environment while using workspace
```
terraform plan -var-file=dev.tfvars
OR
terraform plan -var-file dev.tfvars
```

### Rewrites config files to canonical format
```
terraform fmt
``` 
### Manually unlock the state for the defined configuration.
* the force-unlock command requires a unique lock ID. Terraform will output this lock ID if unlocking fails
```
 terraform force-unlock LOCK_ID [DIR]
```

### Command: refresh
* Update local state file against real resources
```
terraform refresh
```

### Command: taint
* The terraform taint command manually marks a Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
```
terraform taint [options] address
terraform taint aws_security_group.allow_all
```

### Command: untaint
* Manually unmark a resource as tainted
```
terraform untaint [options] name
terraform untaint aws_security_group.allow_all
```

### Command: validate
* It is use to check if the configuration is valid
```
terraform validate
```

### fmt command (to reformat code)
```
terraform fmt
```

### Force and destroy resources (example: s3 with content)
```
terraform destroy --force
```

### Plan destroy
```
terraform plan -destroy
```

### Save a plan
```
terraform plan -out example.tfplan
terraform apply example.tfplan
```

### Variables
* Terraform will automatically loads all files which match `terraform.tfvars` or `*.tfvars` or `.auto.tfvars` from the current directory.
* Other files can be passed explicitly using `-var-file` flag
```tf
terraform plan -var-file=secrets.tfvars -var-file=dmz.tfvars -target=module.directory-service -out plan
```

### To set auto-approve of apply and destroy for the current section
```tf
export TF_CLI_ARGS_destroy="-auto-approve"
export TF_CLI_ARGS_apply="-auto-approve"
```

### To remove auto-approve of apply and destroy for the current section
```tf
export TF_CLI_ARGS_destroy=" "
export TF_CLI_ARGS_apply=" "
```
### Terraform output (this will display all the outputs in the state file)
```
terraform output
```

export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"



### Module Sources
* Generic Git Repository. For example, to use HTTPS or SSH:
```tf
module "vpc" {
  source = "git::https://example.com/vpc.git"
}

module "storage" {
  source = "git::ssh://username@example.com/storage.git"
}
```  

* The value of the ref argument can be any reference that would be accepted by the git checkout command, including branch and tag names.
* By default, Terraform will clone and use the default branch (referenced by HEAD) in the selected repository. You can override this using the ref argument:

```tf 
module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
}
```

### Module Sources example
* ref=development: we are refer to the development branch
```tf
source            = "../../terraform/ec2/"
source = "github.com/leonardtia1/test-module/terraform/ec2"
source = "git::https://github.com/leonardtia1/test-module.git"
source = "git::https://github.com/leonardtia1/test-module.git?ref=development"
source = "git::ssh://github.com/leonardtia1/test-module.git"
```

### From each Module
```
terragrunt plan
terragrunt apply
terragrunt output
terragrunt destroy
```

### From a root module
```
terragrunt plan-all
terragrunt apply-all
terragrunt output-all
terragrunt destroy-all
```




### Scp command
```
 scp -r tia@10.0.0.34:/home/tia/Downloads/terraform-jed .
```















1. terraform destroy -target resource_type.resource_logical_name

2. terraform get -update=true

3. terraform output -module=module-name

4.terraform plan -target=module.cloudgeeks.ca-vpc ---> only plan specific modules

5.terraform apply -target=module.cloudgeeks.ca-vpc ---> only apply specific modules

6.terraform state pull----> ok

7.terraform state push---->danger

8.terraform state rm module.cloudgeeks.ca-rds-app1  ----> https://stackoverflow.com/questions/43950097/how-to-import-manual-changes-into-terraform-remote-state

9.terraform show ---> see after deployment

10. terraform state list

#Note: Pull directly from git hub

#https://www.terraform.io/docs/modules/sources.html

11. source = "github.com/quickbooks2018/Terraform-Classic-Modules/modules/vpc"

# ssh generate public key from a private key

12. ssh-keygen -y -f terraform.pem > terraform.pub

13. terraform apply -var-file=dmz.tfvars

14. terraform destroy -var-file=dmz.tfvars

15. terraform import -var-file=dmz.tfvars module.sg7.aws_security_group.security_group sg-00afc6e255cc55387 

16. terraform plan -var-file=secrets.tfvars -var-file=dmz.tfvars -target=module.directory-service -out plan
