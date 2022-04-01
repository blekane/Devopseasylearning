
## Terraform Variables
* Terraform has the capability to output the attribute of a resource with the output values.
* An outputed attributes can not only be used for the user reference but it can also act as an input to other resources being created via terraform
* Let’s understand this with an example: 
    * After EIP gets created, it’s IP address should automatically get display and the bucket DNS

### Display attributes of resources
* This will give us the value associted with every attribute for a specific resource that are on AWS console 
* NB: These attributes are also listed in the terraform state file in the output section for all the resources.
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  vpc      = true
}

output "eip" {
  value = aws_eip.lb
}

resource "aws_s3_bucket" "mys3" {
  bucket = "kplabs-attribute-demo-005"
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3
}
```

```tf
Outputs:

eip = {
  "association_id" = ""
  "domain" = "vpc"
  "id" = "eipalloc-0907598c33fa340e9"
  "instance" = ""
  "network_interface" = ""
  "private_ip" = ""
  "public_dns" = "ec2-54-163-183-102.compute-1.amazonaws.com"
  "public_ip" = "54.163.183.102"
  "public_ipv4_pool" = "amazon"
  "tags" = {}
  "vpc" = true
}
mys3bucket = {
  "acceleration_status" = ""
  "acl" = "private"
  "arn" = "arn:aws:s3:::kplabs-attribute-demo-005"
  "bucket" = "kplabs-attribute-demo-005"
  "bucket_domain_name" = "kplabs-attribute-demo-005.s3.amazonaws.com"
  "bucket_regional_domain_name" = "kplabs-attribute-demo-005.s3.amazonaws.com"
  "cors_rule" = []
  "force_destroy" = false
  "hosted_zone_id" = "Z3AQBSTGFYJSTF"
  "id" = "kplabs-attribute-demo-005"
  "lifecycle_rule" = []
  "logging" = []
  "object_lock_configuration" = []
  "region" = "us-east-1"
  "replication_configuration" = []
  "request_payer" = "BucketOwner"
  "server_side_encryption_configuration" = []
  "versioning" = [
    {
      "enabled" = false
      "mfa_delete" = false
    },
  ]
  "website" = []
}
```
### Output 
* Check for Attributes Reference in the link to see all the option that tyou can display.

* [Data Source: aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eip#public_ip)

* [Resource: aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)

```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  vpc      = true
}

output "eip" {
  value = aws_eip.lb.public_ip
  
}

resource "aws_s3_bucket" "mys3" {
  bucket = "kplabs-attribute-demo-005"
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
  /*
  value2 = aws_s3_bucket.mys3.arn
  value3 = aws_s3_bucket.mys3.region
  value4 = aws_s3_bucket.mys3.website_domain
  value5 = aws_s3_bucket.mys3.id
  */
}
```

```tf
Outputs:

eip = 54.163.183.102
mys3bucket = kplabs-attribute-demo-005.s3.amazonaws.com
```