* [Github Link](https://github.com/WillBrock/terraform-course-examples)
* [YouTube link](https://www.youtube.com/watch?v=Abv3CHS4HTE)

### Workspaces
* Workspaces are used to manage multiple environement at the same time with different state file and the same configuration file.
* We have only one workspace by default which is the default workspace.

### The terraform workspace list command is used to list all existing workspaces.
* Usage: terraform workspace list
* The command will list all existing workspaces. The current workspace is indicated using an asterisk (*) marker.
```tf
$ terraform workspace list
  default
* development
  jsmith-test
```

### The terraform workspace select command is used to choose a different workspace to use for further operations.
* Usage: terraform workspace select [NAME]
```tf
$ terraform workspace list
  default
* development
  jsmith-test

$ terraform workspace select default
Switched to workspace "default".
```

### The terraform workspace new command is used to create a new workspace
* Usage: terraform workspace new [NAME]
```tf
$ terraform workspace new example
Created and switched to workspace "example"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```

### The terraform workspace delete command is used to delete an existing workspace.
* -force - Delete the workspace even if its state is not empty. Defaults to false.
* Usage: terraform workspace delete [NAME]

```tf
$ terraform workspace delete example
Deleted workspace "example".
```

### The terraform workspace show command is used to output the current workspace.
* Usage: terraform workspace show
* The command will display the current workspace.
```tf
$ terraform workspace show
development
```
### To deploy resources in the dev environment while using workspace
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