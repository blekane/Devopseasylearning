### Reference
* [Download terraform](https://www.terraform.io/downloads.html)
* [AWS CLI download](https://aws.amazon.com/cli/)
* [Terraform Releases](https://releases.hashicorp.com/terraform/)

### Terraform installation on Windows:
[terraform 13.5](https://releases.hashicorp.com/terraform/0.13.5/)

* Unzip the folder
* create a folder call terraform on the C drive and paste the terraform.exe
* Type `env` on windows search bar and at it to path `C:\terraform`

### Install AWS CLI on Linux 
* [Donload AWS CLI link](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install)

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version
```

### Configure the AWS CLI
```
aws configure
```
Region: us-esat-1
* Output can be:
    * Table
    * Json (default)


### Terraform v0.13.5 installation on Linux
* [Terraform Releases](https://releases.hashicorp.com/terraform/)
* 1- Download the binary terraform file.
* 2- Move it into a rigth path.
```sh
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
# To check
./terraform
mv terraform /usr/local/bin
```
* Check the version
```
terraform -version
```

### Terraform v0.12.26 installation on Linux
* [Terraform Releases](https://releases.hashicorp.com/terraform/)
```sh
wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
mv terraform /usr/local/bin
```
* Check the version
```
terraform -version
```

### Terraform v0.12.30 installation on Linux
* [Terraform Releases](https://releases.hashicorp.com/terraform/)
```sh
wget https://releases.hashicorp.com/terraform/0.12.30/terraform_0.12.30_linux_amd64.zip
unzip terraform_0.12.30_linux_amd64.zip
mv terraform /usr/local/bin
```
* Check the version
```
terraform -version
```

