### Use employeer identity or ID to create resources
* Any resource that an employee creates should be created with the name of his identification number only and the resource name

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
