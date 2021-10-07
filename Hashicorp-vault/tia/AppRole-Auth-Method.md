# AppRole Auth Method
The approle auth method allows machines or apps to authenticate with Vault-defined roles. 

### Enable the AppRole auth method
```
vault auth list

vault auth enable approle
vault auth tune -description="This method is for applications and machines " approle/
```

### Create a named role
```s
vault write auth/approle/role/my-role \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40

vault write auth/approle/role/my-role \
    role_name="my-role" \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40
```

### Parameters
AppRole Auth Method Role Parameters [here](https://www.vaultproject.io/api/auth/approle#role_name)

**- secret_id_ttl**`(string: "")` - Duration in either an integer number of seconds (3600) or an integer time unit (60m) after which any SecretID expires.

**- token_num_uses** `(integer: 0)` - The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited. 

**- token_ttl** `(integer: 0 or string: "")` - The incremental lifetime for generated tokens. This current value of this will be referenced at renewal time.

**- token_max_ttl** `(integer: 0 or string: "")` - The maximum lifetime for generated tokens. This current value of this will be referenced at renewal time.

**- secret_id_num_uses**`(integer: 0)` - Number of times any particular SecretID can be used to fetch a token


### Fetch the RoleID of the AppRole
```s
$ vault read auth/approle/role/my-role/role-id
role_id     0a3e355a-426e-6be9-4e09-d4f040aca96e
```

### Get a SecretID issued against the AppRole
```
$ vault write -f auth/approle/role/my-role/secret-id
secret_id             75c0201b-3b52-94f4-ebfa-78d97dda772c
secret_id_accessor    e73770c7-72d6-c69b-7533-694933f669ee
secret_id_ttl         10m
```        

### Login with AppRole
```s
# set variables
ROLE_ID_MY_ROLE=0a3e355a-426e-6be9-4e09-d4f040aca96e 
SECRET_ID_MY_ROLE=917b99a8-9e71-b252-afb5-67afa69bd224

export ROLE_ID_MY_ROLE 
export SECRET_ID_MY_ROLE

echo $ROLE_ID_MY_ROLE
echo $SECRET_ID_MY_ROLE

# login
write auth/approle/login role_id=$rROLE_ID_MY_ROLE secret_id=$SECRET_ID_MY_ROLE

write auth/approle/login \
    role_id=$rROLE_ID_MY_ROLE \
    secret_id=$SECRET_ID_MY_ROLE

# OR

vault write auth/approle/login \
    role_id=0a3e355a-426e-6be9-4e09-d4f040aca96e \
    secret_id=917b99a8-9e71-b252-afb5-67afa69bd224

# unset variables
unset ROLE_ID_MY_ROLE
unset SECRET_ID_MY_ROLE
```

## Create a web app role
**NB:** Secret_id_num_uses=1 means it can be use only one time within 1hour
```s
vault write auth/approle/role/webapp role_name="webapp" secret_id_num_uses=1 secret_id_ttl=2h

# OR

vault write auth/approle/role/webapp \
    role_name="webapp" \
    secret_id_num_uses=1 \
    secret_id_ttl=2h

# OR

vault write auth/approle/role/webapp \
    secret_id_num_uses=1 \
    secret_id_ttl=2h

# Get the roleId
vault read auth/approle/role/webapp/role-id
roleId=ROLEID
ROLEID_WEBAPP=d1960deb-c919-7ac2-4533-6bdd6c3ec2f7


# Get the secretId
vault write -force auth/approle/role/webapp/secret-id
secretId=SECRETID
SECRETID_WEBAPP=ead393d3-7d76-9eb9-0385-6fdfe320ea0c 
````

# Login
vault write auth/approle/login role_id=$ROLEID_WEBAPP secret_id=$SECRETID_WEBAPP
```

### List roles
```s
vault list auth/{auth_method}/role
vault list auth/approle/role
vault list auth/userpass/role
vault list auth/token/role
```
### Delete roles
```
vault delete auth/{auth_method}/role/{role_name}
vault delete auth/approle/role/webapp
vault delete auth/approle/role/my-role
```

### Disable AppRole Auth Method
```
vault auth disable approle
``