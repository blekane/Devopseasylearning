
## Approach for Variable Assignment
* we can create a variable file to put all our variables and put the values is `terraform.tfvars`
* NB: `terraform.tfvars` is a naming convention 
* if you change the `terraform.tfvars` to somthing else like `custom.tfvars`, you must provide it while running terraform plan command. `terraform plan -var-file="custom.tfvars` because terraform is going to look for variables values in `terraform.tfvars`
* It is a good practice to have a variables file and the `terraform.tfvars` in the production env.
```
terraform plan -var-file="custom.tfvars"
```

### From a File (terraform.tfvars):
* If they is any value specify in `terraform.tfvars`, that value will be created by default "t2.large". This is where we can change the type.
```tf
instancetype="t2.large"
```

### From a File (variables.tf):
* If they is not value specify in `terraform.tfvars`, "t2.mcrio" will be created by default
```tf
variable "instancetype" {
  default = "t2.mcrio"
}
```