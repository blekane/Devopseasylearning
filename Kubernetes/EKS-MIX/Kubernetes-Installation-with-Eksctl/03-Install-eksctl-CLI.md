### Linux installation
- [Installing or upgrading eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html#installing-eksctl)

### To install or upgrade eksctl on Linux using curl
- [Install link](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html#installing-eksctl)
- Download and extract the latest release of eksctl with the following command.
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
```
- Move the extracted binary to /usr/local/bin.
```
sudo mv /tmp/eksctl /usr/local/bin
```
- Test that your installation was successful with the following command.
```
eksctl version
```
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
eksctl version
```