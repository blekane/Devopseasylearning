
#### MacOS
```
brew tap hashicorp/tap
brew install hashicorp/tap/vault
```

### Ubuntu
Download Vault [here](https://www.vaultproject.io/downloads)
```sh
Download Vault [here](https://www.vaultproject.io/downloads)
apt update
apt install curl -y
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault
```

### Check the version
```
vault version 
```

