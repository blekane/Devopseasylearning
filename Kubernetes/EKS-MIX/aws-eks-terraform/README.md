
https://github.com/SummitRoute/aws_managed_policies/tree/master/policies


2- Run the below command to export the .kube/config file in your home directory

$ aws eks update-kubeconfig --name [cluster_name] --region [region]
Example: aws eks update-kubeconfig --name eks --region us-east-1