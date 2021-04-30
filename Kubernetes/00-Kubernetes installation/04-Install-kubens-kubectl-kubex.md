### Install kubectl on CentOs
- [Installing kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
```sh
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
kubectl
```

### Install kubectx on CentOs
* [link](https://centos.pkgs.org/7/harbottle-main-x86_64/kubectx-0.6.3-1.el7.harbottle.x86_64.rpm.html)
```sh
wget https://harbottle.gitlab.io/harbottle-main/7/x86_64/harbottle-main-release.rpm
rpm -Uvh harbottle-main-release.rpm
yum install kubectx -y
kubectx
```

### Install kubens on CentOs
* [links](https://github.com/ahmetb/kubectx/releases)
```sh
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.1/kubens_v0.9.1_linux_x86_64.tar.gz
tar -zxvf kubens_v0.9.1_linux_x86_64.tar.gz
mv kubens /usr/local/bin/
kubens
```

### AWS CLI
```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version
```

### Install kubectl on Ubuntu
```sh
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
```

### Install kubectx and kubens on Ubuntu
```sh
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
chmod +x kubectx kubens
sudo mv kubens kubectx /usr/local/bin

kubectx --help
kubens --help
```

