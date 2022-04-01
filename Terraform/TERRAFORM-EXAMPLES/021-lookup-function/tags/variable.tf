variable "s3_bucket_prefix" {
  type        = string
  description = "Prefix of the S3 bucket"
  default = "my-bucket12547"
}

variable "s3_tags" {
    type = map

    default = {
        created_by  = "Terraform"
        environment = "test"
        project     = "MAM"
    }
}

variable "s3_region" {
    type = list
    default = ["us-east-1", "us-east-2"]
}
