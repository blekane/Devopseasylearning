### Helm 3 Install on Ubuntu
* [From Apt Debian/Ubuntu](https://www.lynda.com/Helm-tutorials/Install-Helm-Linux/2830010/3127213-4.html?autoplay=true)

```
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

### Install helm 2.17 on CentOs and Ubuntu
```
cd /tmp 
wget https://get.helm.sh/helm-v2.17.0-linux-amd64.tar.gz -O /tmp/helm.tar.gz ; \
tar xf helm.tar.gz ; \
mv linux-amd64/helm /usr/local/bin/
helm version --short
```

### Install Helm 3 on CentOs and Ubuntu
* [Helm release](https://github.com/helm/helm/releases)
* [Helm Website](https://helm.sh/)
* [Quickstart Guide](https://helm.sh/docs/intro/quickstart/)
```
curl -LO https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
tar -zxvf helm-v3.5.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
helm version --short
```
* Add helm report
```
helm repo add stable https://charts.helm.sh/stable
```

### Remove Helm 
```
yum remove helm -y
apt-get remove helm -y
```