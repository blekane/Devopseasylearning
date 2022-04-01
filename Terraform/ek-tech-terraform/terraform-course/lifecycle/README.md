
### Lifecycle 

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