### How to Install Visual Studio Code on Ubuntu 20.04
```
sudo snap install --classic code
snap install --classic code
```

### AWS CLI
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version
```


### Installing kubectl
```sh
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/
kubectl
```

### Install kubectx and kubens
```sh
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
chmod +x kubectx kubens
sudo mv kubens kubectx /usr/local/bin

kubectx --help
kubens --help
```

### How to install docker on ubuntu
```sh
sudo apt-get update && \
    sudo apt-get install docker.io -y
```

OR 

```
sudo apt-get update
apt-get remove docker docker-engine docker.io
apt install docker.io
systemctl start docker
systemctl enable docker
docker --version
```

### Install Kind
* 1- Golang tool installation
* [Download golang](https://golang.org/dl/)
```sh
wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
tar -xvzf go1.15.7.linux-amd64.tar.gz -C /usr/local
cd /usr/local/go/bin/
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile # or vim /etc/profile
source /etc/profile
go version
```

* 2- Install Kind
* [Kind setup Github page](https://github.com/kubernetes-sigs/kind)
```sh
GO111MODULE="on" go get sigs.k8s.io/kind@v0.9.0
find / -name kind
cd /root/go/bin/
cp kind /usr/local/bin/kind
kind version
```

### Install Helm 3
```sh
curl -LO https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
tar -zxvf helm-v3.5.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
helm version --short
helm repo add stable https://charts.helm.sh/stable
```

### Install helm 2.17
```
cd /tmp 
wget https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz -O /tmp/helm.tar.gz ; \
tar xf helm.tar.gz ; \
mv linux-amd64/helm /usr/local/bin/
helm version --short
```