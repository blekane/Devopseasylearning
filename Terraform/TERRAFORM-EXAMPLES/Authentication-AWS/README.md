## Authentication To AWS
* [Authentication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [AWS | Terraform Tutorial 2 | Authentication Types — AWS Provider | AWS](https://www.youtube.com/watch?v=eA9pls88bdU)

The AWS provider offers a flexible means of providing credentials for authentication. The following methods are supported, in this order, and explained below:
* Static credentials
* Environment variables
* Shared credentials/configuration file
* CodeBuild, ECS, and EKS Roles
* EC2 Instance Metadata Service or EC2 role

### EC2
Note that every region has a different AMI ID. The AMI ID's keeps on changing so make sure you use the latest AMI ID from the AWS console similar to the way it is shown in the video.

### first_ec2.tf
```tf
provider "aws" {
  region     = "us-east-1"
  access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}

resource "aws_instance" "myec2" {
   ami = "ami-007a607c4abd192db"
   instance_type = "t2.micro"
   key_name   = "jenkins-key"

  tags = {
    Name = "test"
  }
}
```

### Commands:
```sh
terraform init
terraform plan
terraform apply
terraform destroy
```

### Static Credentials
* Warning:
  * Hard-coding credentials into any Terraform configuration is not recommended, and risks secret leakage should this file ever be committed to a public version control system.
  * Static credentials can be provided by adding an access_key and secret_key in-line in the AWS provider block:
  
```tf
provider "aws" {
  region     = "us-east-1"
  access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}
```

```tf
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3PBICDDCKP3QM4WIDD"
  secret_key = "RIXSYP0XGHLohZo6SsMysZht7WRHiFUCQnhJu7ahrf"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = "t2.micro"
   key_name   = "jenkins-key"

  tags = {
    Name = "test"
  }
}
```

### Environment Variables
Run these 3 commands in the folder where you have your Terraform script through command. We do not need to do this if the AWS CLI is already set up. it will use the crendential that we set up the AWS CLI with by default.
```tf
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="us-east-1"
terraform plan
```

```tf
### Run these 3 commands in the folder where you have your Terraform script through command. We do not need to do this if the AWS CLI is already set up
export access_key="AKIA3PBICDDCKP3QM4WIDD"
export secret_key="RIXSYP0XGHLohZo6SsMysZht7WRHiFUCQnhJu7ahrf"
export AWS_DEFAULT_REGION="us-east-1"
```

```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = "t2.micro"
   key_name   = "jenkins-key"

  tags = {
    Name = "test"
  }
}
```

### Shared Credentials File
We need to configure the customprofile and use it into a script
* Sample Template
```tf
provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/Users/tf_user/.aws/creds"
  profile                 = "customprofile"
}
```

* This is wath we have when we configure the AWS CLI
```sh
[root@localhost ~]# cat ~/.aws/config
[default]
region = us-east-1
output = json
[root@localhost ~]# cat ~/.aws/credentials
[default]
aws_access_key_id = AKIA3PBICDDCKP3QM4WIDD
aws_secret_access_key = RIXSYP0XGHLohZo6SsMysZht7WRHiFUCQnhJu7ahrf
[root@localhost ~]#
```
* Configure the customprofile 
```sh
aws configure --profile customprofile
```

```sh
[root@localhost ~]# aws configure --profile customprofile
AWS Access Key ID [None]: AKIA3PBICDDCKP3QM4WIDD
AWS Secret Access Key [None]: RIXSYP0XGHLohZo6SsMysZht7WRHiFUCQnhJu7ahrf
Default region name [None]: us-east-1
Default output format [None]: json
```
* This is wath we have when we the customprofile

```sh
[root@localhost ~]# cat ~/.aws/config
[default]
region = us-east-1
output = json
[profile customprofile]
region = us-east-1
output = json
[root@localhost ~]# cat ~/.aws/credentials
[default]
aws_access_key_id = AKIA3PBICDDCKP3QM4WIDD
aws_secret_access_key = RIXSYP0XGHLohZo6SsMysZht7WRHiFUCQnhJu7ahrf
[customprofile]
aws_access_key_id = AKIA3PBICDDCKP3QM4WIDD
aws_secret_access_key = RIXSYP0XGHLohZo6SsMysZht7WRHiFUCQnhJu7ahrf
```

* Configure the customprofile (make sure to change the path "/Users/tf_user/.aws/creds" base on yours)

```tf
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "customprofile"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = "t2.micro"
   key_name   = "jenkins-key"

  tags = {
    Name = "test"
  }
}
```

### EC2 role or EC2 Instance Metadata Service 
This is a preferred approach over any other when running in EC2 as you can avoid hard coding credentials. Instead.

* Assume Role (Steps)
  * Launch and EC2 instance in AWS
  * Create an IAM role with EC2 full access and attach to the instance 
  * Install terraform
  * Initialize Terrform and run your script
  * We do not need to set up the AWS CLI Here

* Example Code
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = "t2.micro"
   key_name   = "jenkins-key"

  tags = {
    Name = "test"
  }
}
```


```tf
provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}
```





