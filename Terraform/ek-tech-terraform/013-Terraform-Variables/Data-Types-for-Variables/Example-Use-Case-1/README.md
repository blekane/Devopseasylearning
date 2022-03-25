### Use employeer identity or ID to create resources
* Every employee in IT is assigned an Identification Number.
* Any resource that an employee creates should be created with the name of the identification (identity or ID) number only.

### Code without variables
```tf 
provider "aws" {
  region     = "us-east-1"
}

resource "aws_iam_user" "lb" {
   name = "demouser"
   path = "/system/"
}
```

### Code with variable
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_iam_user" "lb" {
   name = var.usernumber
   path = "/system/"
}
```
