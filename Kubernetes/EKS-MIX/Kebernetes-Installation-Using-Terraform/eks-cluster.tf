module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  tags = {
    Environment = "development"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }


  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

cluster_endpoint_private_access = "true"
  cluster_endpoint_public_access  = "true"

  write_kubeconfig      = true
  manage_aws_auth       = true

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      asg_desired_capacity          = 2
      asg_max_size                  = 5
      asg_min_size                  = 2
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.micro"
      asg_desired_capacity          = 1
      asg_max_size                  = 5
      asg_min_size                  = 1
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}