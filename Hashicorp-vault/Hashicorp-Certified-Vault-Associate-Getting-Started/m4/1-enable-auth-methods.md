# Userpass Auth Method

### Login
```
vault login 
```
# Check auth methods that are avilable now
The default authentification method in vault is `token`
```
vault auth list
```

### Userpass Auth Method

What is user pass authentication? [here](https://www.vaultproject.io/docs/auth/userpass)

The userpass auth method allows users to authenticate with Vault using a `username and password` combination.

The username/password combinations are configured directly to the auth method using the `users/`

### Enable the userpass auth method
```
vault auth enable userpass
vault auth disable userpass
```
### Add description
```
vault auth tune -description="This is for username and password method" userpass/
```

### Configure  users that are allowed to authenticate

This creates a new user "mitchellh" with the password "foo"
```
vault write auth/userpass/users/mitchellh password=foo 
```

This creates a new user "mitchellh" with the password "foo" that will be associated with the "admins" policy.
```
vault write auth/userpass/users/mitchellh \
    password=foo \
    policies=admins
```

### Authentication Via the CLI
This creates a new user "mitchellh" with the password "foo" that will be associated with the "admins" policy.

```
vault login -method=userpass \
    username=mitchellh \
    password=foo
```





# And we'll also enable AppRole, but we'll do it using the UI
# Open your browser to http://127.0.0.1:8200
# We are going to mount it at the path GloboAppRole

# Now let's check the list of auth methods again
vault auth list

# Oh no! We forgot to add descriptions! Better take care of that
vault auth tune -description="Globomantics Userpass" userpass/

vault auth tune -description="Globomantics AppRole" GloboAppRole/

vault auth list

# Much better! Now we can configure our two auth methods in step 2



example-vault-admin-policy.hcl
```sh
# Allow managing leases
path "sys/leases/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage auth methods broadly across Vault
path "auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create, update, and delete auth methods
path "sys/auth/*"
{
  capabilities = ["create", "update", "delete", "sudo"]
}

# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
}

# List existing policies
path "sys/policies/acl"
{
  capabilities = ["read","list"]
}

# Create and manage ACL policies
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secret engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing secret engines.
path "sys/mounts"
{
  capabilities = ["read"]
}

# Read health checks
path "sys/health"
{
  capabilities = ["read", "sudo"]
}
```


