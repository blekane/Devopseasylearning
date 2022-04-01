### Default configuration (deploy in 1 region and  1 account)
* config 
```
[default]
output = json
region = us-east-1
```
* credentials
```
[default]
aws_access_key_id = " "
aws_secret_access_key = " "
```

### Resources
```tf
provider "aws" {
  region     =  "us-east-1"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}
```

### Deploy resources in 2 regions
```tf
provider "aws" {
  region     =  "us-east-1"
}

provider "aws" {
  alias      = "ohio"
  region     =  "us-east-2"
}



resource "aws_eip" "myeip" {
  vpc = "true"
}

resource "aws_eip" "myeip1" {
  vpc = "true"
  provider = aws.ohio
}
```

### Deploy in multiple accounts

* config file 
```
[default]
output = json
region = us-east-1

[account02]
output = json
region = us-east-1
```

* credentials file
```
[default]
aws_access_key_id = " "
aws_secret_access_key = " "

[account02]
aws_access_key_id = " "
aws_secret_access_key = " "
```

* Test 
```
aws s3 ls
aws s3 ls --profile default
aws s3 ls --profile account02
```

* Default
```tf
provider "aws" {
  region     =  "us-east-1"
  profile    = "default"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}
```

* Account 02
```tf
provider "aws" {
  region     =  "us-east-1"
  profile    = "accont02"
}

resource "aws_eip" "myeip" {
  vpc = "true"
}
```

### Deploy in multiple accounts at the same time
```tf
provider "aws" {
  region     =  "us-east-1"
  profile    = "default"
}


provider "aws" {
  alias      = "aws_aws02"
  region     = "us-east-1"
  profile    = "account02"
}


resource "aws_eip" "myeip01" {
  vpc = "true"
}

resource "aws_eip" "myeip02" {
  vpc = "true"
  provider = aws.aws_aws02
}
```

```tf
provider "aws" {
  alias      = "aws_default"
  region     =  "us-east-1"
  profile    = "default"
}


provider "aws" {
  alias      = "aws_aws02"
  region     = "us-east-1"
  profile    = "account02"
}


resource "aws_eip" "myeip01" {
  vpc = "true"
  provider = aws.aws_aws02
}

resource "aws_eip" "myeip02" {
  vpc = "true"
  provider = aws.aws_default
}
```