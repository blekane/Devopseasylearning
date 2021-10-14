## Vault Quick Setup
- HashiCorp Vault Setup [here](https://www.youtube.com/watch?v=TO557f1-Ksk)
- Repository [here](https://github.com/quickbooks2018/docker/tree/master/vault-docker)

### Login
```
docker exec -it vault sh
ROOT_TOKEN=[ROOT_TOKEN_VALUE_HERE]
ROOT_TOKEN=s.7fX9gEzMfwCMrO8hqtUa5AWF
export ROOT_TOKEN
export VAULT_ADDR=http://127.0.0.1:8200
vault login -address=$VAULT_ADDR $ROOT_TOKEN
```
