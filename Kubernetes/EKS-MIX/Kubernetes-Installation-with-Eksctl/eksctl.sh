#!/bin/bash

# Create Cluster
eksctl create cluster --name=eksdemo1 \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup

# Template to create OIDC identity provider
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster eksdemo1 \
    --approve

# Create Public Node Group
eksctl create nodegroup --cluster=eksdemo1 \
                        --region=us-east-1 \
                        --name=eksdemo1-ng-public1 \
                        --node-type=t2.micro \
                        --nodes=1 \
                        --nodes-min=1 \
                        --nodes-max=4 \
                        --node-volume-size=20 \
                        --ssh-access \
                        --ssh-public-key=jenkins-key \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access 


<< comment
Export the cluster .kube/config file
aws eks update-kubeconfig --name [cluster_name] --region [region]
Example: aws eks update-kubeconfig --name eksdemo1 --region us-east-1

Delete Cluster  
eksctl delete cluster <clusterName>
eksctl delete cluster eksdemo1
comment