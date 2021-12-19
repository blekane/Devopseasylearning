### Deploy K8S with eksctl

1. How to install EKSCTL in CentOs and Ubuntu
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
eksctl version
```
2. Create the ClusterConfig file
vim cluster-1.18.yaml
```yml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: devops-catalog
  region: us-east-1
  version: "1.18"
managedNodeGroups:
- name: primary-1-18
  instanceType: t2.small
  minSize: 3
  maxSize: 6
  spot: true
```

vim cluster-1.21.yaml
```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: devops-catalog
  region: us-east-1
  version: "1.21"
managedNodeGroups:
- name: primary-1-21
  instanceType: t2.micro
  minSize: 1
  maxSize: 3
  spot: true
```


3. Export these variables
```
export AWS_ACCESS_KEY_ID=[...]

export AWS_SECRET_ACCESS_KEY=[...]

export KUBECONFIG=$PWD/kubeconfig.yaml
```

4. Create the cluster
```yaml
eksctl create cluster \
    --config-file cluster-1.18.yaml

OR

eksctl create cluster \
    --config-file cluster-1.21.yaml
```

6. Export the cluster .kube/config file
```
aws eks update-kubeconfig --name [cluster_name] --region [region]
Example: aws eks update-kubeconfig --name devops-catalog --region us-east-1
```

5. Delete the cluster
```yaml
eksctl delete cluster --region=us-east-1 --name=devops-catalog

or

eksctl delete cluster \
  --region=us-east-1 \
  --name=devops-catalog
```