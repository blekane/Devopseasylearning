
## Terraform for AWS Notes

### There are various types of tools that can allows you to deploy infrastructure as code
* Terraform
* CloudFormation
* Ansible
* SaltSack
* Chef, Puppet and other


### Which tools to choose for infrastructure as code?
* If your infrastructure is going to be vendor specific in longer term? Example AWS: you can choose Cloudformation.
* If you are planning to use multiple cloud providers, Terraform will be the best choice.


### Pros of Terraform
* Terraform support multiple platform. It has 100 of providers
* Easy to intergrate with configuration management like Ansible
* Easily extensible with the help of plugins
* It free

### Lists of Terraform Providers
* [Terraform supported platforms](https://www.terraform.io/docs/providers/index.html)

* [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)



### Delete all resources create by terraform with `terraform destroy`
* This will destroy all the resource this the Terraform state fiel
* if you want to destroy a particular resource, you can either command that resource in the state file and run Terraform apply or you can use `terraform destroy --target <resource name>` to do that.
* This command `terraform destroy --target <resource name>` will remove the resource in the state file and if your `terraform apply again`, it will create the resource again.
* The best way to destroy the resource is to remove it in `.tf` file or to command it in `.tf` file and run terraform apply command.


 ### Understanding Terraform State files
 * How does Terraform know if the resources were created or deleted? It uses the state file
 * Terraform will store all the resources that you created in the `terraform.tfstate` file.
* When we delete a resource, Terraform will remove that resource in the state file

This state file do not have any resource.
```tf
{
  "version": 4,
  "terraform_version": "0.13.5",
  "serial": 21,
  "lineage": "f52b6086-afa2-62cb-21d5-853af2b067b1",
  "outputs": {},
  "resources": []
}
```

### Terraform plan command
* When your run `Terraform plan` command, always check this line: `Plan: 1 to add, 0 to change, 0 to destroy.`
* This is because if terraform want to destroy something, it will be listed on this line.
* Avoid deleting resource manual through AWS console while using Terraform because this will create a challenge. When you will run `terraform apply` command it will always try to create resources that were deleted manually through the console.


### Understanding Desired & Current States
* Let say you have deploy a `t2.micro` EC2 using terraform and latter on, someone manually change the instance type through AWS console to `m4.large`.
* The `m4.large` that is currenty running is the di=esired state and the `t2.micro` in the terraform state file is the current state of your insfrastructure.
* The manual changes are called desired state and the details store in the terraform file are called current state
* When you run the `terraform plan`, it always try to match the desired state to current state
* A lot of time working in the production environment, you will realize that the desired and current state are different.
* NB: The desired state is what is actually runing in AWS console and the current state is what we have in Terraform state file because they will be manual changes that will be done to you insfrastructure. You need to decide what to do if the cuurent is different from the desired state.


### Refresh Command
When we run terraform apply command, it refreshes the state file first to match the disered state to the current state. We can also run the `terraform refresh` command to refresh the state file.
```
terraform refresh
```
```tf
# current state
"instance_state": "running",
"instance_type": "t2.micro",

# Stop EC2 on aws console
"instance_state": "stopped",
"instance_type": "t2.micro",

# change the instance type from t2.micro to "t2.nano"
"instance_state": "running",
"instance_type": "t2.micro", >>>> "t2.nano"

# run terraform apply. This will always change the desired state to the current state.
"instance_state": "running",
"instance_type": "t2.micro"
```

### Challenges with the current state on computed values
* If will create and Ec2 instance with terraform without a security and latter create a SG and change the default SG, terraform will not manage that because they is no information about the SG in the state file.
* The default SG in not part of the current state
* if you make a manual change that is not defined in the state file, terraform will not do anything with that resource.

### Provider and Resources
* Terraform supports multiple providers.
* We have to specify the provider details for which we want to launch the infrastructure
* With the provider, we also have to add the tokens which will be used for authentication.
* On adding a provider, terraform init will download plugins associated with the provider.

### Terraform State File
* Terraform stores the state of the infrastructure that is being created from the TF files.
* This state allows terraform to map real-world resource to your existing configuration.
* Multiple resources in Terraform will have a separate block with the state file.


### Current State vs Desired State
* When running a terraform plan, Terraform must know the current state of resources in order to effectively determine the changes that it needs to make to reach your desired configuration.
* Current State = Current Infrastructure Resource & Configuration
* Desired State = Infrastructure Configuration defined within the Terraform TF Files.
* Terraform will plan to match the desired state to the current state. If there is a difference between both, the desired state will take the preference.


### Destroying Infrastructure With Terraform
* The terraform destroy command is used to destroy the Terraform-managed infrastructure.
* This will ask for confirmation before destroying it
* If -auto-approve is set, then the destroy confirmation will not be shown.


### Terraform Provider Versioning
* The provide add as a middle or interface between terraform and the service provider
* Provider have multiple versioning. For instance, Windows have a lot of version such Windows 10, 7, XP, server and so on.
* Provider plugins are released separately from Terraform itself.
* They have a different set of version numbers.

### Explicitly Setting Provider Version
* During terraform init, if version argument is not specified, the most recent provider will be downloaded during initialization.
* For production use, you should constrain the acceptable provider versions via configuration, to ensure that new versions with breaking changes will not be automatically installed.
* AWS latter version is `hashicorp/aws: version = "~> 3.10.0"`. Type terraform init to see the version.
* This is because new version most be tested in the test enveronement before deploy to production.

```tf
provider "aws" {
  region  = "us-east-1"
  version = "2.7"
}
```

```tf
provider "aws" {
  # ... other configuration ...

  version = "~> 2.70"
}


provider "aws" {
  # ... other configuration ...

  version = "~> 3.0"
}
```

### Arguments for Specifying the provider
* There are multiple ways of specifying the version of a provider.
  * `>=1.0`: Download plogins that are greater than or equal to one
  * `<=1.0`: Download plogins that are less than or equal to one
  * `~>2.0`: Download plogins in the 2.X range
  * `>=2.10,<=2.30`: Download any plogins version between 2.10 and 2.30

```tf
version    = "2.7"
version    = ">= 2.8"
version    = "<= 2.8"
version    = ">=2.10,<=2.30"
```

```tf
provider "aws" {
    region = "us-east-1"
    version = ">=2.8,<=2.30"
}
resource "aws_s3_bucket" "terraform_s3" {
    bucket = "terraform-bucket-232"
    acl = "private"
}
```

### Terraform Providers
There are two major categories for terraform providers
* HashiCorp Distributed provider
* 3rd party provider
  * HashiCorp Distributed providers can be downloaded automatically during terraform init.
  * terraform init cannot automatically download providers that are not distributed by HashiCorp

### Overview of 3rd Party Providers
* It can happen that the official provider does not support specific functionality.
* Some organizations might have their proprietary platform for which they want to use Terraform.
* For such cases, individuals can decide to develop/use 3rd party providers.

### Understanding Attributes and Output Values
* Terraform has the capability to output the attribute of a resource with the output values.
* An outputed attributes can not only be used for the user reference but it can also act as an input to other resources being created via terraform


### Module Sources
* Generic Git Repository. For example, to use HTTPS or SSH:
```tf
module "vpc" {
  source = "git::https://example.com/vpc.git"
}

module "storage" {
  source = "git::ssh://username@example.com/storage.git"
}
```

* The value of the ref argument can be any reference that would be accepted by the git checkout command, including branch and tag names.
* By default, Terraform will clone and use the default branch (referenced by HEAD) in the selected repository. You can override this using the ref argument:

```tf
module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
}
```

### Module Sources example
* ref=development: we are refer to the development branch
```tf
source            = "../../terraform/ec2/"
source = "github.com/leonardtia1/test-module/terraform/ec2"
source = "git::https://github.com/leonardtia1/test-module.git"
source = "git::https://github.com/leonardtia1/test-module.git?ref=development"
source = "git::ssh://github.com/leonardtia1/test-module.git"
```

### Counts and counting
```tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami                         = "${lookup(var.ami, var.region)}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${module.vpc.public_subnet_id}"
  associate_public_ip_address = true
  user_data                   = "${file("files/web_bootstrap.sh")}"
  vpc_security_group_ids = [
    "${aws_security_group.web_host_sg.id}",
  ]
  count = 2
}
```
* It’ll create each resource with the index of the count suffixed to the resource name, like so:
```tf
aws_instance.web.0
aws_instance.web.1
```
* To access the id of one of these instances we’d use:
```tf
aws_instance.web.0.id
```

### Sets of counted resources using splat
* Sometimes we want to refer to the set of resources created via a count. To do this Terraform has a splat syntax: *. This allows us to refer to all of these resources in a variable. Let’s see how that works in the aws_elb.web resource.
```tf
resource "aws_elb" "web" {
  name            = "web-elb"
  subnets         = ["${module.vpc.public_subnet_id}"]
  security_groups = ["${aws_security_group.web_inbound_sg.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  instances = ["${aws_instance.web.*.id}"]
}
```

### Bit
* cidrsubnet: it use to calculate subnets
* 8 is the number of bits
* if the numer of bit is 8, we have the below subnets.(255.255.255.0)
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"

private_cidrs   = [
      + "10.0.3.0/24",
      + "10.0.4.0/24",
      + "10.0.5.0/24",
    ]

public_cidrs    = [
      + "10.0.0.0/24",
      + "10.0.1.0/24",
      + "10.0.2.0/24",
    ]
```

* if the numer of bit is 4, we have the below subnets.
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"

+ private_cidrs   = [
      + "10.0.48.0/20",
      + "10.0.64.0/20",
      + "10.0.80.0/20",
    ]

  + public_cidrs    = [
      + "10.0.0.0/20",
      + "10.0.16.0/20",
      + "10.0.32.0/20",
    ]
```
* if the numer of bit is 10, we have the below subnets.
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 10, count.index)}"
+ private_cidrs   = [
      + "10.0.0.192/26",
      + "10.0.1.0/26",
      + "10.0.1.64/26",

  + public_cidrs    = [
      + "10.0.0.0/26",
      + "10.0.0.64/26",
      + "10.0.0.128/26",
    ]
```

### map and format
* "%s-repository" for no arg >> "mam-dev-repository"
```tf
bucket = format("%s-repository", var.tags["environment"])
```

* %s-repository-%s for 1 arg >> "mam-dev-repository-us-east-1"
```tf
resource "aws_s3_bucket" "repository" {
  bucket = format("%s-repository-%s", var.tags["environment"], data.aws_region.current.name)
```

* %s-repository-%s for 2 args >> mam-dev-repository-us-east-1-788210522308
```tf
bucket = format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
```

```tf
tags   = merge(map("Name", format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)), map("csp_exception", "true"), map("Others tags", "just for for testing"), var.tags)

"Name           = "mam-dev-repository-us-east-1-788210522308"
"Others tags"   = "just for for testing"
"csp_exception" = "true"
"environment"   = "mam-dev"
"project"       = "mam"
"project-id"    = "82540"
"terraform"     = "yes"
```

* "%s-repository-%s-%s-%s" for 3 args >> "mam-dev-repository-82540-us-east-1-788210522308"
```tf
bucket = format("%s-repository-%s-%s-%s", var.tags["environment"], var.tags["project-id"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
```
* "%s-repository-%s-%s-%s-%s" for 5 args  and so on

### Null in terraform
* null: a value that represents absence or omission. If you set an argument of a resource or module to `null`, Terraform behaves as though you had completely omitted it. null is most useful in conditional expressions.

### Condition
* Create allocated_storage only if snapshot_identifier is set to null, else, set allocated_storage to null
```tf
variable "_rds_defaults" {
  description = "Default rds properties, if not overridden"
  type        = map(string)
  default = {
    snapshot_identifier         = null
    allocated_storage           = "250"
    max_allocated_storage       = "2" # multiplier for allocated_storage
  }
}
```

* Create max_allocated_storage only if snapshot_identifier is set to null. max_allocated_storage = allocated_storage x 2 = 250 x 2 = 500. else, set allocated_storage to null
```tf
max_allocated_storage = local.rds["snapshot_identifier"] == null ? local.rds["allocated_storage"] * local.rds["max_allocated_storage"] : null


variable "_rds_defaults" {
  description = "Default rds properties, if not overridden"
  type        = map(string)
  default = {
    snapshot_identifier         = null
    allocated_storage           = "250"
    max_allocated_storage       = "2" # multiplier for allocated_storage
  }
}
```
* if default is set to null, do not create rds_password. if default is not set to null, create `1` rds_password because `count` is `1`. RDS PASSWORD will be created here because default is not set to `null` or equal `null`.
```tf
count       = var.rds_password != null ? 1 : 0

variable "rds_password" {
  type        = string
  description = "Master DB password for RDS. Should not be placed in source code. Either use terraform.tfvars or enter when running Terraform."
  default     = "DefaultPassword!23"
}
```

* create isprod if t_environment is set to PRD. Else, do not create isprod. isprod will not be created because t_environment = "DEV". it will be create only if t_environment = "PRD"
```tf
isprod              = local.tags["t_environment"] == "PRD" ? true : false

 tags = {
      environment   = "${local.common.environment}"
      t_environment = "DEV" # Must be one of the following values - DEV, DR, POC, PRD, PRF, QA, STG, TST. Pick the one that matches your environment the closest.
    }
```

* If the variable kms_arn is not set to `null`, create it. Else set it to `null` or do not create it. kms_arn will not be create because it is set to `null` already.
```tf
kms_key_id  = var.kms_arn != null ? var.kms_arn : null

variable "panel_key" {
  type        = string
  default     = null
}
```
* tobool : it use to convert element init boolean. if boolean instance_start = true, execute local.bastion["instance_count"]. else, do nothing or false
```tf
bastion_instance_start = tobool(local.bastion["instance_start"]) == true ? local.bastion["instance_count"] : 0
```

* If condition is true then the result is `true_val`. If condition is false then the result is `false_val`.
```tf
condition ? true_val : false_val
```

* If `var.a` is an empty string then the result is `"default-a"`, but otherwise it is the actual value of `var.a.`
```tf
var.a != "" ? var.a : "default-a"
```

* Never use the `== or !=` operators to compare Boolean values, since these perform string comparisons, and cannot handle the multiple possible synonyms of true and false. For example, instead of:
```tf
var.x == true ? var.y : var.z
```
* simply use:
```tf
var.x ? var.y : var.z
```

```tf
provider "aws" {
  region = "us-east-1"
}

variable "create_id" {
  default = true
}

resource "random_id" "id1" {
  # resource wil be created because 1 is true
  count = "${var.create_id ? "1" : "0"}"
  byte_length = 2
}

resource "random_id" "id2" {
# resource wil be created because 0 is is false
count = "${var.create_id ? "0" : "1"}"
  byte_length = 2
}

#RESULT
Terraform will perform the following actions:

  # random_id.id1[0] will be created
  + resource "random_id" "id1" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 2
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

### Resource: aws_db_instance
- [Provides an RDS instance resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#allocated_storage)

- `allow_major_version_upgrade` - (Optional) Indicates that major version upgrades are allowed.

- `auto_minor_version_upgrade` - (Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true.

- `backup_retention_period` - (Optional) The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica. See Read Replica.

- `apply_immediately`- (Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. using apply_immediately can result in a brief downtime as the server reboots.

- `backup_window` - (Optional) The daily time range (in UTC) during which automated backups are created if they are enabled. Example: "09:46-10:16". Must not overlap with maintenance_window

- `delete_automated_backups` - (Optional) Specifies whether to remove automated backups immediately after the DB instance is deleted. Default is true.

- `deletion_protection` - (Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false.

- `final_snapshot_identifier` - (Optional) The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false.

- `enabled_cloudwatch_logs_exports` - (Optional) Set of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine). MySQL and MariaDB:`(audit, error, general, slowquery)`. PostgreSQL: `(postgresql, upgrade)`. MSSQL: `(agent , error. Oracle: alert, audit, listener, trace)`.
```tf
enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
```

### Splat Expressions
* If `var.list` is a list of objects that all have an attribute id, then a list of the ids could be produced with the following for expression:
```tf
[for o in var.list : o.id]
```
* This is equivalent to the following splat expression:
```tf
var.list[*].id
```

### Working with Console Recorder for AWS
* [Console Recorder for AWS](https://chrome.google.com/webstore/detail/console-recorder-for-aws/ganlhgooidfbijjidcpkeaohjnkeicba?hl=en)
* [AWS Console Recorder - Demonstration](https://www.youtube.com/watch?v=u1crm24vTpA&t=4s)
* Use the link above to add the extent to google
* Launch the recording and start creating resources.
* Stop the recording when the resources creation is done
* Open Recorder dashboard and click Terraform to get the code


### Format Function
- Function [here](https://www.terraform.io/docs/language/functions/format.html)
- How to use format function in Terraform [here](https://stackoverflow.com/questions/67039404/how-to-use-format-function-in-terraform)

I am trying to register an application in Azure AD using TF and i would like to define some redirect URIs using the arg as mentioned in the link -->
```
https://(project code)-yellow-(resourcegroup).azurewebsites.net/oauth2-redirect.html
https://(project code)-blue-(resourcegroup).azurewebsites.net/oauth2-redirect.html
https://(project code)-green-(resourcegroup).azurewebsites.net/oauth2-redirect.html
```

You can pass the project_id and resourcegroup as input parameters to your TF code:
```t
variable "project_id" {}
variable "resource_group" {}
```
Then your reply_urls could be:
```t
reply_urls  = [
       format("https://%s-yellow-%s.azurewebsites.net/oauth2-redirect.html", var.project_id, var.resource_group),
       format("https://%s-blue-%s.azurewebsites.net/oauth2-redirect.html", var.project_id, var.resource_group),
       format("https://%s-green-%s.azurewebsites.net/oauth2-redirect.html", var.project_id, var.resource_group)
]
```
- `%s` is for string
- `%d` Convert to integer number and produce decimal representation.
- `%02d` is for `count.index + 1` , 0`0 + 1`, 0`1 + 1`, 0`2 + 1`
```t
option      = format("redis node %02d for %s cluster", count.index + 1, var.environment)
```

### Conditionals
```t
resource "aws_instance" "web" {
  subnet = "${var.env == "production" ? var.prod_subnet : var.dev_subnet}"
}

resource "aws_instance" "vpn" {
  count = "${var.something ? 1 : 0}"
}
``

- Equality: == and !=
- Numerical comparison: >, <, >=, <=
- Boolean logic: &&, ||, unary !


### Module Sources
* Generic Git Repository. For example, to use HTTPS or SSH:
```tf
module "vpc" {
  source = "git::https://example.com/vpc.git"
}

module "storage" {
  source = "git::ssh://username@example.com/storage.git"
}
```

* Here we’re downloading the production branch of the module in the tf_vpc repository.
```tf
module "vpc" {
source = "git::https://github.com/turnbullpress/tf_vpc.git?ref=production"
}
```


* The value of the ref argument can be any reference that would be accepted by the git checkout command, including branch and tag names.
* By default, Terraform will clone and use the default branch (referenced by HEAD) in the selected repository. You can override this using the ref argument:
* v1.2.0 = tag in git

```tf
module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
}
```

## Modules in Package Sub-directories [here](https://www.terraform.io/language/modules/sources)

When the source of a module is a version control repository or archive file (generically, a "package"), the module itself may be in a sub-directory relative to the root of the package.

A special double-slash syntax is interpreted by Terraform to indicate that the remaining path after that point is a sub-directory within the package. For example:

```
hashicorp/consul/aws//modules/consul-cluster
git::https://example.com/network.git//modules/vpc
https://example.com/network-module.zip//modules/vpc
s3::https://s3-eu-west-1.amazonaws.com/examplecorp-terraform-modules/network.zip//modules/vpc
git::https://example.com/network.git//modules/vpc?ref=v1.2.0
```

### Module Sources example
* ref=development: we are refer to the development branch
```tf
source = "./vpc"
source = "../../terraform/ec2/"
source = "github.com/leonardtia1/test-module/terraform/ec2"
source = "git::https://github.com/leonardtia1/test-module.git"
source = "git::https://github.com/leonardtia1/test-module.git?ref=development"
source = "git::ssh://github.com/leonardtia1/test-module.git"
```

### Tags
* Here we’re downloading the production branch of the module in the tf_vpc repository.
```tf
module "vpc" {
source = "git::https://github.com/turnbullpress/tf_vpc.git?ref=production"
}
```
* Committing and pushing our vpc module
```tf
$ pwd
~/terraform/web/vpc
$ git add .
$ git commit -m "First commit of VPC module"
$ git tag -a "v0.0.1" -m "First release of vpc module"
$ git remote add origin git@github.com:turnbullpress/tf_vpc.git
$ git push -u origin master --tags
```
* Updating our vpc module configuration
```tf
module "vpc" {
source = "github.com/turnbullpress/tf_vpc.git?ref=v0.0.1"
name = "web"
cidr = "10.0.0.0/16"
public_subnet = "10.0.1.0/24"
}
```

* We’ll need to get our module again since we’ve changed its source. Getting the new vpc module.
```tf
$ terraform get
Get: git::https://github.com/turnbullpress/tf_vpc.git?ref=v0.0.1
```

* Any time we want to use the vpc module, we can now just reference the module on GitHub. This also means we can manage multiple versions of the module—for example, we could create `v0.0.2` of the module, and then use the `ref` parameter to refer to that.
* This allows us to test a new version of a module without changing the old one.

```tf
$ pwd
~/terraform/web/vpc
$ git add .
$ git commit -m "First commit of VPC module"
$ git tag -a "v0.0.2" -m "Second release of vpc module"
$ git remote add origin git@github.com:turnbullpress/tf_vpc.git
$ git push -u origin master --tags
```

```tf
module "vpc" {
source = "github.com/turnbullpress/tf_vpc.git?ref=v0.0.2"
name = "web"
cidr = "10.0.0.0/16"
public_subnet = "10.0.1.0/24"
}
```

### Git Basics - Tagging
```
git tag -a v1.4 -m "my version 1.4"
git tag
git show v1.4
```
