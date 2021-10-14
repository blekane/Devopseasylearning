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

### Help
```
vault -help
vault server -help
```

### Start Vault in development mode
```
vault server -dev
```
### Open a second console and save the token in a variable
DO NOT USE VAULT_TOKEN for the variable name
```
ROOT_TOKEN=[ROOT_TOKEN_VALUE_HERE]
ROOT_TOKEN=s.pkWjl98aImxhANgYGmnbW9aG
export ROOT_TOKEN
```
Let's log into the Vault server using our root token and the Vault server address. The default launch of the development server is listening on the loopback address and port 8200
```s
vault login -address="http://127.0.0.1:8200" $ROOT_TOKEN
```

### Export the environment variable
If we run vault  status, it will fails because we have not yet export the environment variable and it using https `https://127.0.0.1:8200/v1/sys/seal-status"`
```
export VAULT_ADDR=http://127.0.0.1:8200
```

### Check the status
```
vault status
```

```
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.8.3
Storage Type    inmem
Cluster Name    vault-cluster-93a4bebc
Cluster ID      1f29ae46-fe17-dbae-457e-5df52f03708f
HA Enabled      false
```

### Grap the root token
```
echo $ROOT_TOKEN
```

### Now open a browser on 
Open firefox on your curent VM on `http://127.0.0.1:8200/ui`
```
http://127.0.0.1:8200/ui

OR

http://127.0.0.1:8200
```
