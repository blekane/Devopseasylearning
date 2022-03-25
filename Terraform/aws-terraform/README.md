## Terraform on AWS EC2, VPC, ALB, CLB, NLB, Autoscaling, Route53, ACM, CloudWatch, SNS, CodePipeline, CodeBuild, S3

- [Course Main Repository](https://github.com/stacksimplify/terraform-on-aws-ec2)

- [IAC DevOps Repository](https://github.com/stacksimplify/terraform-iacdevops-with-aws-codepipeline/tree/main/terraform-manifests)


## Map and list
```t
# AWS EC2 Instance Type - List

variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t3.micro", "t3.small", "t3.large"]  
}

# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa" = "t3.small"
    "prod" = "t3.large"
  }
}

# Resources
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  #instance_type = var.instance_type_list[1]  # For List
  #nstance_type = var.instance_type_map["prod"]  # For Map
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ]
  count = 2
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
}
```

## Understand about count index
- If we currently see all our EC2 Instances has the same name `web`
- Lets name them by using count index `web-0, web-1, web-2, web-3, web-4`
```t
# Create EC2 Instance
resource "aws_instance" "web" {
  ami = "ami-047a51fa27710816e" # Amazon Linux
  instance_type = "t2.micro"
  count = 5
  tags = {
    #"Name" = "web"
    "Name" = "web-${count.index}"
  }
}
```

## Count and index
```s
# The index will be 0,1,2,3,and 4
count = 5 
count.index
0, 1, 2, 3, 4

count = 2 
count.index
0, 1

  count = 2
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }

# EC instance name

Count-Demo-0
Count-Demo-1

  count = 5
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }

# ECinstance name

Count-Demo-0
Count-Demo-1
Count-Demo-2
Count-Demo-3
Count-Demo-4
```

## For Loops
- for loop with List
- for loop with Map
- for loop with Map Advanced
```t

# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.myec2vm[*].public_dns
}
```

## Arguments for Specifying the provider

[hashicorp/terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws)
[terraform-provider-aws](https://registry.terraform.io/providers/hashicorp/aws/latest)
[terraform release versions](https://releases.hashicorp.com/terraform/)

* There are multiple ways of specifying the version of a provider.
  * `>=1.0`: Download plogins that are greater than or equal to one
  * `<=1.0`: Download plogins that are less than or equal to one
  * `~>2.0`: Download plogins in the 2.X range
  * `>=2.10,<=2.30`: Download any plogins version between 2.10 and 2.30

  * `>=0.13.5`: Use terraform 0.13.5 version upward
  * `~>0.13`: Use terraform >=0.13 still >0.14 ----> 0.13  still 0.13.9
  * `>=0.13,<=0.15`: Use terraform >=0.13 still <=0.15 ----> 0.13 still 0.15
 
### Create a simple terraform block and play with required_version
- `required_version` focuses on underlying Terraform CLI installed on your desktop
- If the running version of Terraform on your local desktop doesn't match the constraints specified in your terraform block, Terraform will produce an error and exit without taking any further actions.
- By changing the versions try `terraform init` and observe whats happening

```t
Play with Terraform Version
  required_version = "~> 0.14.3" 
  required_version = "= 0.14.3"    
  required_version = "= 0.14.4"  
  required_version = ">= 0.13"   
  required_version = "= 0.13"    
  required_version = "~> 0.13" 
  required_version = ">=0.13,<=0.15"  
 ```

### Add Provider and play with Provider version
- `required_providers` block specifies all of the providers required by the current module, mapping each local provider name to a source address and a version constraint.
```t
Play with Provider Version
      version = "~> 3.0"            
      version = ">= 3.0.0, < 3.1.0"
      version = ">= 3.0.0, <= 3.1.0"
      version = "~> 2.0"
      version = "~> 3.0"   
```

```t
version    = "2.7"
version    = ">= 2.8"
version    = "<= 2.8"
version    = ">=2.10,<=2.30"
```

```t
provider "aws" {
    region = "us-east-1"
    version = ">=2.8,<=2.30"   
}
```

```t
# Terraform Block
terraform {
  required_version = ">=0.13,<=0.15" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  
    }
  }
}
```

```t
# Terraform Block
terraform {
  required_version = "~> 0.13" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  # 3.0 still 3.99 but not 4.0
    }
  }
}
```

## Understand about Terraform Top-Level Blocks
  - Terraform Settings Block
  - Provider Block
  - Resource Block
  - Input Variables Block
  - Output Values Block
  - Local Values Block
  - Data Sources Block
  - Modules Block

```t
# Block-1: Terraform Settings Block
terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  # Adding Backend as S3 for Remote State Storage with State Locking
  backend "s3" {
    bucket = "terraform-stacksimplify"
    key    = "dev2/terraform.tfstate"
    region = "us-east-1"  

    # For State Locking
    dynamodb_table = "terraform-dev-state-table"
  }
}

# Block-2: Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}

# Block-3: Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-04d29b6f966df1537" # Amazon Linux
  instance_type = var.instance_type
}

# Block-4: Input Variables Block
variable "instance_type" {
  default = "t2.micro"
  description = "EC2 Instance Type"
  type = string
}

# Block-5: Output Values Block
output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.my-ec2-vm.public_ip
}

# Block-6: Local Values Block
# Create S3 Bucket - with Input Variables & Local Values
locals {
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"
}

# Block-7: Data sources Block
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

# Block-8: Modules Block
# AWS EC2 Instance Module

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-modules-demo"
  instance_count         = 2

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  monitoring             = true
  vpc_security_group_ids = ["sg-08b25c5a5bf489ffa"]  # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-4ee95470" # Get one public subnet id from default vpc and replace
  user_data               = file("apache-install.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```


## Implement `for_each` with **Maps**

```t
terraform {
  required_version = "~> 0.13" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_s3_bucket" "mys3bucket" {

  # for_each Meta-Argument
  for_each = {
    dev  = "my-dapp-bucket"
    qa   = "my-qapp-bucket"
    stag = "my-sapp-bucket"
    prod = "my-papp-bucket"
  }

  bucket = "${each.key}-${each.value}"
  acl    = "private"

  tags = {
    Environment = each.key
    bucketname  = "${each.key}-${each.value}"
    eachvalue   = each.value
  }
}

## dev
aws_s3_bucket.mys3bucket["dev"] will be created
bucket = "dev-my-dapp-bucket"
 + tags                        = {
          + "Environment" = "dev"
          + "bucketname"  = "dev-my-dapp-bucket"
          + "eachvalue"   = "my-dapp-bucket"
        }

## qa
aws_s3_bucket.mys3bucket["qa"] will be created
bucket = "dev-my-dapp-bucket"
 + tags                        = {
          + "Environment" = "qa"
          + "bucketname"  = "qa-my-dapp-bucket"
          + "eachvalue"   = "my-dapp-bucket"
        }

## stage
aws_s3_bucket.mys3bucket["stage"] will be created
bucket = "dev-my-dapp-bucket"
 + tags                        = {
          + "Environment" = "stage"
          + "bucketname"  = "stage-my-dapp-bucket"
          + "eachvalue"   = "my-dapp-bucket"
        }

## prod
aws_s3_bucket.mys3bucket["prod"] will be created
bucket = "dev-my-dapp-bucket"
 + tags                        = {
          + "Environment" = "prod"
          + "bucketname"  = "prod-my-dapp-bucket"
          + "eachvalue"   = "my-dapp-bucket"
        }
```

## Implement `for_each` with Set of Strings
```t
terraform {
  required_version = "~> 0.13" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


resource "aws_iam_user" "myuser" {
  for_each = toset( ["Jack", "James", "Madhu", "Dave"] )
  name     = each.key
}
```

## lifecyle Meta-Argument block contains 3 arguments
- create_before_destroy
- prevent_destroy
- ignore_changes

## lifecyle - create_before_destroy
- Default Behavior of a Resource: Destroy Resource & re-create Resource
- With Lifecycle Block we can change that using `create_before_destroy=true`
  - First new resource will get created
  - Second old resource will get destroyed
- **Add Lifecycle Block inside Resource Block to alter behavior**  
```t
terraform {
  required_version = "~> 0.13" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_instance" "web" {
  ami               = "ami-0915bcb5fa77e4892" # Amazon Linux
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "web-1"
  }

  lifecycle {
    create_before_destroy = true
  }
}
```

## Lifecycle - prevent_destroy
- This meta-argument, when set to true, will cause Terraform to reject with an error any plan that would destroy the infrastructure object associated with the resource, as long as the argument remains present in the configuration.
- This can be used as a measure of safety against the accidental replacement of objects that may be costly to reproduce, such as database instances
- However, it will make certain configuration changes impossible to apply, and will prevent the use of the `terraform destroy` command once such objects are created, and so this option should be used `sparingly`.
- Since this argument must be present in configuration for the protection to apply, note that this setting does not prevent the remote object from being destroyed if the resource block were removed from configuration entirely: in that case, the `prevent_destroy` setting is removed along with it, and so Terraform will allow the destroy operation to succeed.
```t
  lifecycle {
    prevent_destroy = true # Default is false
  }
```