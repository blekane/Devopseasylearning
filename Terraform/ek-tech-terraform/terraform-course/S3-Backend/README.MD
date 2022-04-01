### Create the backend
```tf
# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "bucket_name" {
  default = "red30-tfstate"
}

# //////////////////////////////
# PROVIDER
# //////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-2"
}

# //////////////////////////////
# TERRAFORM USER
# //////////////////////////////
data "aws_iam_user" "terraform" {
  user_name = "terraform"
}

# //////////////////////////////
# S3 BUCKET
# //////////////////////////////
resource "aws_s3_bucket" "red30-tfremotestate" {
  bucket = var.bucket_name
  force_destroy = true
  acl = "private"

  versioning {
    enabled = true
  }

  # Grant read/write access to the terraform user
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_iam_user.terraform.arn}"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "red30-tfremotestate" {
  bucket = aws_s3_bucket.red30-tfremotestate.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# //////////////////////////////
# DYNAMODB TABLE
# //////////////////////////////
resource "aws_dynamodb_table" "tf_db_statelock" {
  name           = "red30-tfstatelock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# //////////////////////////////
# IAM POLICY
# //////////////////////////////
resource "aws_iam_user_policy" "terraform_user_dbtable" {
  name = "terraform"
  user = data.aws_iam_user.terraform.user_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["dynamodb:*"],
            "Resource": [
                "${aws_dynamodb_table.tf_db_statelock.arn}"
            ]
        }
   ]
}

EOF
}
```

### Eample code using the backend
```tf
# //////////////////////////////
# BACKEND
# //////////////////////////////
terraform {
  backend "s3" {
  }
}

# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  default = "172.16.0.0/24"
}

# //////////////////////////////
# PROVIDERS
# //////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}


# //////////////////////////////
# MODULES
# //////////////////////////////
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-module-example"

  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}
```

### Initialize the backend
```
terraform init \
    -backend-config="bucket=red30-tfstate" \
    -backend-config="key=red30/ecommerceapp/app.state" \
    -backend-config="region=us-east-2" \
    -backend-config="dynamodb_table=red30-tfstatelock" \
    -backend-config="access_key={ACCESS_KEY}" \
    -backend-config="secret_key={SECRET_KEY}"
```

```
terraform init \
    -backend-config="bucket=red30-tfstate" \
    -backend-config="key=red30/ecommerceapp/app.state" \ 
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=red30-tfstatelock" \
    -backend-config="access_key=AKIAXXXXXXXXXXXXXXXX" \
    -backend-config="secret_key=123XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```

```
terraform init \
    -backend-config="bucket=terraform-tia-backend" \
    -backend-config="key=dev/app1/remotedemo.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=terraform-s3-state-lock" \
    -backend-config="access_key=AKIAXXXXXXXXXXXXXXXX" \
    -backend-config="secret_key=123XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```

## State Backend
```tf
terraform {
  backend "s3" {
    bucket  = "mybucket"
    key     = "aws/example/prod"
    region  = "eu-central-1"
    profile = "default"
    encrypt = "true"
    lock_table = "terraform"
  }
}
```

```tf
terraform {
backend "s3" {
bucket = "ops"
key = "terraform/state/ops-com"
region = "us-east-1"
encrypt = "true"
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
    }
}
```

```tf
# stage/frontend-app/main.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "stage/frontend-app/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}
```

### Example
```tf
terraform {
  backend "s3" {
    access_key = " "
    secret_key = " "
    bucket = "terraform-tia-backend"
    key    = "remotedemo.tfstate" // this is the tfstate file name
    region = "us-east-1"
    dynamodb_table = "terraform-s3-state-lock"
  }
}
```
```tf
terraform {
  backend "s3" {
  }
}
```
```
terraform init \
    -backend-config="bucket=terraform-tia-backend" \
    -backend-config="key=remotedemo.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=terraform-s3-state-lock" \
    -backend-config="access_key=AKIAXXXXXXXXXXXXXXXX" \
    -backend-config="secret_key=123XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```