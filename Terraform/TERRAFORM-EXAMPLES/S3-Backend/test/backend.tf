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

/*
terraform init \
    -backend-config="terraform-tia-backend" \
    -backend-config="key=remotedemo.tfstate" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=terraform-s3-state-lock" \
    -backend-config="access_key=ACCESS_KEY" \
    -backend-config="secret_key=SECRET_KEY"
*/