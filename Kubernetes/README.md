# Kubernetes system administrator

- **Lab reference 1:** https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-interactive/

* Base64 encode [here](https://www.base64encode.org/)

- **Lab reference 1:** ](https://www.katacoda.com/courses/kubernetes/)playground

* [Kubernetes Documentation](https://kubernetes.io/docs/concepts/)

* [Terraform and EKS: a Step-by-Step Guide to Deploying Your First Cluster](https://www.fairwinds.com/blog/terraform-and-eks-a-step-by-step-guide-to-deploying-your-first-cluster)


### Install kubectl on Linux
```sh
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

### EKS Installation using terraform
* [Step-by-Step Guide to Deploying Your First Cluster](https://www.fairwinds.com/blog/terraform-and-eks-a-step-by-step-guide-to-deploying-your-first-cluster)

```tf
provider "aws" {
  version = "~> 2.57.0"
  region  = "us-east-1"
}


locals {
  cluster_name = "my-eks-cluster"
}

module "vpc" {
  source = "git::https://git@github.com/reactiveops/terraform-vpc.git?ref=v5.0.1"

  aws_region = "us-east-1"
  az_count   = 3
  aws_azs    = "us-east-1a, us-east-1b, us-east-1c"

  global_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

module "eks" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name = local.cluster_name
  vpc_id       = module.vpc.aws_vpc_id
  subnets      = module.vpc.aws_subnet_private_prod_ids

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 3
      min_capaicty     = 3

      instance_type = "t2.small"
    }
  }

  manage_aws_auth = false
}
```

