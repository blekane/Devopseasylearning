### Velero 
* [Velero doc](https://velero.io/docs/v1.5/)
* It is a tool that runs in K8 cluster use to backup and restore the entire cluster or namespaces.
* it can also backup data inside volumes

### 1- Install Kind

### 2- Create a cluster
* Lets create a Kubernetes cluster to play with using Kind
```
kind create cluster --name velero --image kindest/node:v1.19.1
```

### 3- deploy some example applicatipon
```
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0 --generator=run-pod/v1

kubectl expose pod my-first-pod  --type=NodePort --port=80 --name=my-first-service
```

### 4- Run a small `alpine linux` container where we can install and play with `velero`:
* This run a container an log me in
```
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host alpine sh
```

### 5 install curl & kubectl inside the container
* install curl to downlaod kubectl
```
apk add --no-cache curl nano
```

* install kubectl
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
export KUBE_EDITOR="vi"
```

* Test if we can access our cluster from the container
```
/work # kubectl get nodes
NAME                    STATUS   ROLES    AGE   VERSION
velero-control-plane   Ready    master   26m   v1.19.1
```

### 6- install Velero CLI in the `alpine linux`
* [release](https://github.com/vmware-tanzu/velero/releases/tag/v1.5.1)
```
curl -L -o /tmp/velero.tar.gz https://github.com/vmware-tanzu/velero/releases/download/v1.5.1/velero-v1.5.1-linux-amd64.tar.gz 
tar -C /tmp -xvf /tmp/velero.tar.gz
mv /tmp/velero-v1.5.1-linux-amd64/velero /usr/local/bin/velero
chmod +x /usr/local/bin/velero

velero --help
```

### 7- Run AWS CLI Container
* Run the aws cli container to interact with AWS and install json
```
docker run -it --rm --entrypoint /bin/sh amazon/aws-cli:2.0.55
```
* install JSON tool (This because aws cli use json output)
```
yum install -y jq
```

### 8- Create a user that can login through the CLI and configure the AWS CLI
```
sh-4.2# aws configure
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: us-east-1
Default output format [None]: json
sh-4.2# aws s3 ls
```
### 8.1- steps
* [link](https://github.com/vmware-tanzu/velero-plugin-for-aws)
* Create an S3 bucket
* Set permissions for Velero
* Install and start Velero
* Migrating PVs across clusters

### 8.2- Velero authentification with AWS
* [authentification plugins:](https://velero.io/plugins/)
* [AWS authentification plugins:](https://github.com/vmware-tanzu/velero-plugin-for-aws)


### 9- Create a Storage Bucket
```
BUCKET=veleromarcel
REGION=ap-southeast-2
aws s3api create-bucket \
    --bucket $BUCKET \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION
```
* NOTE: us-east-1 does not support a LocationConstraint. If your region is us-east-1, omit the bucket configuration:
```
aws s3api create-bucket \
    --bucket $BUCKET \
    --region us-east-1
```

### 10- Create a user, set permission for that user to access S3 bucket, create and access key for the user
* Create user 
aws iam create-user --user-name velero

* Attach policies to give velero the necessary permissions:
```json
cat > velero-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::${BUCKET}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${BUCKET}"
            ]
        }
    ]
}
EOF
```

* assign the policy to the user
```json
aws iam put-user-policy \
  --user-name velero \
  --policy-name velero \
  --policy-document file://velero-policy.json
```

* Create an access key for the user and save it in the file:
```
aws iam create-access-key --user-name velero > /tmp/key.json
cat /tmp/key.json
```

* Set those credential in an evironment variable so that it can be use to configure Velero inside velero container
```
AWS_ACCESS_ID=`cat /tmp/key.json | jq .AccessKey.AccessKeyId | sed s/\"//g`
AWS_ACCESS_KEY=`cat /tmp/key.json | jq .AccessKey.SecretAccessKey | sed s/\"//g`
```

* Export variables with the print function
```
printf "export AWS_ACCESS_ID=$AWS_ACCESS_ID \nexport AWS_ACCESS_KEY=$AWS_ACCESS_KEY\nexport BUCKET=$BUCKET \nexport REGION=$REGION\n"
```

* Copy and paste this to the velero container to set:
```
export AWS_ACCESS_ID=AKIA3PBICDDCOUM7OALQ
export AWS_ACCESS_KEY=xnk8SdJZmSNLY88E9kdn1/PEahD1sBJnqQEdAJwv
export BUCKET=veleromarcel
export REGION=ap-southeast-2
```

### 11- Deploy Velero for AWS (use velero cantainer)

* create a credential file first
```
cat > /tmp/credentials-velero <<EOF
[default]
aws_access_key_id=$AWS_ACCESS_ID
aws_secret_access_key=$AWS_ACCESS_KEY
EOF
```

```
## result
/work # cat /tmp/credentials-velero
[default]
aws_access_key_id=AKIA3PBICDDCOUM7OALQ
aws_secret_access_key=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
/work #
```
* install Velero into a cluster
```
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.1.0 \
    --bucket $BUCKET \
    --backup-location-config region=$REGION \
    --snapshot-location-config region=$REGION \
    --secret-file /tmp/credentials-velero
```
* Check velero pod runing inside the cluster
kubectl -n velero get pods

* check velero deployment logs to make sure that they is no error
```
kubectl -n velero logs [pod name]
kubectl -n velero logs velero-54b4b58d59-hzpbc

kubectl logs deployment/velero -n velero
kubectl logs deployment/velero -n velero |grep -i error
kubectl logs deployment/velero -n velero |grep -i failed
```

### 12- Create a Backup
```
velero backup create default-namespace-backup --include-namespaces default
```

* If the need be use the velero cli to create a custom backup or schedule.
```
velero backup create <BACKUP_NAME> --include-namespaces dev1, dev2
velero schedule create <SCHEDULE_NAME> --schedule="@every 24h" --include-namespaces dev1
```

### Restore from backup 
```
velero restore create <RESTORE_NAME> --from-backup <BACKUP_NAME>
velero restore create default-namespace-backup --from-backup default-namespace-backup
```

* describe
```
velero restore describe default-namespace-backup
```

* logs 
```
velero restore logs default-namespace-backup
```

* see items restored
```
kubectl get all
```


### Velero CLI Instalation
* [valero releases](https://github.com/vmware-tanzu/velero/releases/tag/v1.5.1)

* [Github link](https://github.com/marcel-dempers/docker-development-youtube-series/tree/master/kubernetes/velero)

```sh
curl -L -o /tmp/velero.tar.gz https://github.com/vmware-tanzu/velero/releases/download/v1.5.1/velero-v1.5.1-linux-amd64.tar.gz 
tar -C /tmp -xvf /tmp/velero.tar.gz
mv /tmp/velero-v1.5.1-linux-amd64/velero /usr/local/bin/velero
chmod +x /usr/local/bin/velero

velero --help
```

