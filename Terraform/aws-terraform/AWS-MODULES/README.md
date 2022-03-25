## AWS Terraform Modules
[Terraform Module Registry](https://registry.terraform.io/search/modules)

[Create VPC Terraform Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
```t
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
}
```

[AWS EC2-VPC Security Group Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest)
```t
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws"
}
```

[AWS Key Pair Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/key-pair/aws/latest)
```t
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
}
```

[AWS EKS Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
```t
module "eks" {
  source = "terraform-aws-modules/eks/aws"
}
```

[AWS RDS Aurora Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/rds-aurora/aws/latest)
```t
module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
}
```

[AWS RDS Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest)
```t
module "db" {
  source  = "terraform-aws-modules/rds/aws"
}
```

[AWS Application and Network Load Balancer (ALB & NLB) Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest)
```t
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
}
```

[AWS S3 bucket Terraform module](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest)
```t
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
}
```
