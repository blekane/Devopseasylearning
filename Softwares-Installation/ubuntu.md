apt-get update -y
apt-get install curl -y
apt-get install -y git
apt-get install -y vim


### AWS CLI
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version
```

### Install kubectl
```sh
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
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

### Docker installation
```sh
install docker
sudo apt-get update && \
    sudo apt-get install docker.io -y
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