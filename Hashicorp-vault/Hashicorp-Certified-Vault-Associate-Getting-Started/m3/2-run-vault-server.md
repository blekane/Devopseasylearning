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
root_token=[ROOT_TOKEN_VALUE_HERE]
root_token=s.7VxkbQ0iW1J2qsStiBbypzMU
```
Let's log into the Vault server using our root token and the Vault server address. The default launch of the development server is listening on the loopback address and port 8200
```
vault login -address="http://127.0.0.1:8200" $root_token
```
