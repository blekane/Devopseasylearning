
## Approach for Variable Assignment
* Variables in Terraform can be assigned values in multiple ways.
* Some of these include:
    * Environment variables
    * Command Line Flags
    * From a File
    * Variable Defaults


### Variable Defaults:
* Code without viriable
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = "t2.micro"
}
```
* Create a viriable file variables.tf
```tf
variable "instancetype" {
  default = "t2.micro"
}
```
* Refer the variable in EC.tf file
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = var.instancetype
}
```
* If we don't specify the variable, while running terraform plan, it will use the default variable.
```tf
terraform plan
```
* Specify a variable while runnig terraform plan
```tf
terraform plan -var="instancetype=t2.small"
terraform plan -var="instancetype=t2.large"
```

* If we don't provide any default value in variables.tf, it will prompt us to put the variable while running terraform plan.
```tf
variable "instancetype" {}
```

```tf
$ terraform plan
var.instancetype
  Enter a value: t2.large
```