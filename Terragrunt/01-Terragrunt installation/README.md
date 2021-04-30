### Terragrunt Installation on Windows:
* [Download](https://github.com/gruntwork-io/terragrunt/releases)
* create a folder call terragrunt on the C drive and paste the terragrunt.exe
* Type `env` on windows search bar and at it to path `C:\terragrunt`
```
terragrunt --version
```

### Terragrunt installation on Linux
```
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.26.7/terragrunt_linux_amd64
mv terragrunt_linux_amd64 terragrunt
chmod u+x terragrunt
mv terragrunt /usr/local/bin/terragrunt
terragrunt --version
```