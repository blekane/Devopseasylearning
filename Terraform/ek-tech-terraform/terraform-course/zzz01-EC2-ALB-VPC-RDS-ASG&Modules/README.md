* [21_days_of_aws_using_terraform GitHub link](https://github.com/100daysofdevops/21_days_of_aws_using_terraform)

* [100daysofdevops GitHub link](https://github.com/100daysofdevops/100daysofdevops)

* [Architecture](https://secure.meetupstatic.com/photos/event/e/8/d/2/highres_486419602.jpeg)

### Files that should not be commited on github
* vim .gitignore
* .terraform
* *.tfstate
* *.tfstate.backup

### Variable in Terraform 0.12 and greater
```tf
cidr_block           = var.vpc_cidr
```

### Variable in Terraform less than 0.12
use $ 
```tf
cidr_block           = "${var.vpc_cidr}"
```

### To format your code syntax
```tf
terraform format --diff
```