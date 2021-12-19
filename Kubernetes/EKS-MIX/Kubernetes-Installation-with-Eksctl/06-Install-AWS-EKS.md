# Kubernetes Installatin on AWS Step

### Step-01: Create EKS Cluster using eksctl
- It will take 15 to 20 minutes to create the Cluster Control Plane 

### Template Create Cluster
  - If we don't select the AZs, it will select it automatically
  - without-nodegroup: we added this command because we want create the nodes group. If we don't specify this command, Kubernets will automatically provision a production envirnoment with two m4.large EC2 in the node group without our consent.

```
eksctl create cluster --name=<Cluster name> \
                      --region=<Region where we want to launch the cluster> \
                      --zones=<desire AZs where we want to launch our Cluster> \
                      --without-nodegroup 
```

### Create Cluster
```
eksctl create cluster --name=eksdemo1 \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup 
```

### Get List of clusters
```
eksctl get clusters                  
```

## Step-02: Create & Associate IAM OIDC Provider for our EKS Cluster
- To enable and use AWS IAM roles for Kubernetes service accounts on our EKS cluster, we must create &  associate OIDC identity provider.
- To do so using `eksctl` we can use the  below command. 
- Use latest eksctl version 
                 
### Template to create OIDC identity provider
```
eksctl utils associate-iam-oidc-provider \
    --region <region-code> \
    --cluster <cluter-name> \
    --approve
```

###  Replace with region & cluster name
```
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster eksdemo1 \
    --approve
```


## Step-03: Create EC2 Keypair
- Create a new EC2 Keypair with name as `jenkins-key`
- This keypair we will use it when creating the EKS NodeGroup.
- This will help us to login to the EKS Worker Nodes using Terminal.

## Step-04: Create Node Group with additional Add-Ons in Public Subnets
- These add-ons will create the respective IAM policies for us automatically within our Node Group role.

### Check all the option to create a cluster
```
eksctl create cluster --help |less
```

### check what we can create with eksctl create command
```
eksctl create --help |less 
```
### Check all options to create a Node Group
```
eksctl create nodegroup --help |less
```

### EC2 instance supported by EKS
```
What instance types are supported by EKS?
EKS supports many EC2 instance types, such as `t2`, m3, m4, m5, c4, c5, i3, r3, r4, x1, p2 and p3 instances. The smallest recommended instance type is t2.small; however, you can still use t2.micro for testing purpose.
```

### Template to Create Public Node Group

```
--cluster string                 name of the EKS cluster to add the nodegroup
--region string                  AWS region
--name string                    name of the new nodegroup 
--node-type string               node instance type (default "m5.large")
--nodes-min int                  minimum nodes in ASG (default 2)
--nodes-max int                  maximum nodes in ASG (default 2)
--node-volume-type string        node volume type (valid options: gp2, io1, sc1, st1) (default "gp2")
--node-volume-size int           node volume size in GB (default 80)
--ssh-access                     control SSH access for nodes. Uses ~/.ssh/id_rsa.pub  as default key path if enabled
--ssh-public-key string          SSH public key to use for nodes (import from local path, or use existing EC2 key pair)
--managed                        Create EKS-managed nodegroup
--asg-access                     enable IAM policy for cluster-autoscaler
--external-dns-access            enable IAM policy for external-dns
--full-ecr-access                enable full access to ECR
--appmesh-access                 enable full access to AppMesh
--alb-ingress-access             enable full access for alb-ingress-controller
```  

```sh   
eksctl create nodegroup --cluster=<cluster name> \
                        --region=<region where you want to create a cluster in> \
                        --name=eksdemo1-ng-public1 \
                        --node-type=<nodes EC2 size> \
                        --nodes=<desire nodes to be  up all the time> \
                        --nodes-min=<min nodes> \
                        --nodes-max=<max nodes \
                        --node-volume-size=<node volume size> \
                        --ssh-access \
                        --ssh-public-key=<your keypair> \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access
```

### Create Public Node Group  
- This will take 3 to 5 minutes create the  Node Group 
```sh
eksctl create nodegroup --cluster=eksdemo1 \
                        --region=us-east-1 \
                        --name=eksdemo1-ng-public1 \
                        --node-type=t3.medium \
                        --nodes=2 \
                        --nodes-min=2 \
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
```

### Use a shell script to install a Cluster,  OIDC identity provider and Node Group
-  **Create a file:** cat > eks-cluster.sh (ctrl+d to save)
```sh
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
                        --nodes=2 \
                        --nodes-min=2 \
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
```

### give execute permission to the script and run
```
chmod +x eks-cluster.sh
bash eks-cluster.sh
```

### List Nodes in current kubernetes cluster
```
kubectl get nodes 
kubectl get nodes -o wide
```

### Verify Security Group Associated to Worker Nodes
- Go to Services -> EC2 -> Worker Nodes
- Click on **Security Group** associated to EC2 Instance which contains `remoteAccess` in the name. It is the SG of the cluster and the second is the SG for node group
- Open `all traffic from anywhere` so that we can be able to access web content because only port 22 is open by default


### Login to Worker Node using Keypair
- Login to worker node
```
# For MAC or Linux 
ssh -i jenkins-key.pem ec2-user@<Public-IP-of-Worker-Node>
```

### Update Worker Nodes Security Group to allow all traffic
- We need to allow `All Traffic` on worker node security group


# Delete EKS Cluster & Node Groups

## Important Notes

### Note-1: Rollback any Security Group Changes
- When we create a EKS cluster using `eksctl` it creates the worker node security group with only port 22 access.
- When we progress through the course, we will be creating many **NodePort Services** to access and test our applications via browser. 
- During this process, we need to add an additional rule to this automatically created security group, allowing access to our applications we have deployed. 
- So the point we need to understand here is when we are deleting the cluster using `eksctl`, its core components should be in same state which means roll back the change we have done to security group before deleting the cluster.
- In this way, cluster will get deleted without any issues, else we might have issues and we need to refer cloudformation events and manually delete few things. In short, we need to go to many places for deletions. 

### Note-2: Rollback any EC2 Worker Node Instance Role - Policy changes
- When we are doing `EBS Storage Section with EBS CSI Driver` we will add a custom policy to worker node IAM role.
- When you are deleting the cluster, first roll back that change and delete it. 
- This way we don't face any issues during cluster deletion.

## Step-01: Delete Node Group
- We can delete a nodegroup separately using below `eksctl delete nodegroup`
```
# List EKS Clusters
eksctl get clusters

# Capture Node Group name
eksctl get nodegroup --cluster=eksdemo1

# Delete Node Group
eksctl delete nodegroup --cluster=<clusterName> --name=<nodegroupName>
eksctl delete nodegroup --cluster=eksdemo1 --name=eksdemo1-ng-public1
```

## Step-02: Delete Cluster  
- We can delete cluster using `ereksctl delete cluster`
```
# Delete Cluster
eksctl delete cluster <clusterName>
eksctl delete cluster eksdemo1
```

# EKS Cluster Pricing

## Steo-01: Very Important EKS Pricing Note
- EKS is not free (Unlike other AWS Services)
- In short, no free-tier for EKS.
### EKS Cluster Pricing
    - We pay $0.10 per hour for each Amazon EKS cluster
    - Per Day: $2.4
    - For 30 days: $72
### EKS Worker Nodes Pricing - EC2
    - You pay for AWS resources (e.g. EC2 instances or EBS volumes) 
    - T3 Medium Server in N.Virginia
        - $0.0416 per Hour
        - Per Day: $0.9984 - Approximately $1
        - Per Month: $30 per 1 t3.medium server
    - Reference: https://aws.amazon.com/ec2/pricing/on-demand/
    - In short, if we run 1 EKS Cluster and 1 t3.medium worker node **continuously** for 1 month, our bill is going to be around $102 to $110
    - If we take 5 days to complete this course, and if we run 1 EKS Cluster and 2 t3.medium Worker nodes continuosly for 5 days it will cost us approximately around $25. 

### Important Notes    
- **Important Note-1:** If you are using your personal AWS Account, then ensure you delete and recreate cluster and worker nodes as and when needed. 
- **Important Note-2:** We can't stop our EC2 Instances which are in Kubernetes cluster unlike regular EC2 Instances. So we need to delete the worker nodes (Node Group) if we are not using it during our learning process.


### Additional References
-  [Creating an Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html)
- [Launching self-managed Amazon Linux nodes](https://docs.aws.amazon.com/eks/latest/userguide/create-managed-node-group.html)
- [Enabling IAM roles for service accounts on your cluster](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)
- [What is Amazon EKS?](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [Kubernetes on Amazon (EKS)](https://cloudgeometry.io/blog/amazon-eks/#:~:text=EKS%20supports%20many%20EC2%20instance,and%20OS%20under%20some%20load.)

