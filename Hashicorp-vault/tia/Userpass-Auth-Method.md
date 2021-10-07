# Userpass Auth Method

### Login
```s
vault login 
```
# Check auth methods that are avilable now
The default authentification method in vault is `token`
```s
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
```s
vault auth tune -description="This is for username and password method" userpass/
```

### Configure  users that are allowed to authenticate

This creates a new user "mitchellh" with the password "foo"
```s
vault write auth/userpass/users/mitchellh password=foo 
```

This creates a new user "mitchellh" with the password "foo" that will be associated with the "admins" policy.
```s
vault write auth/userpass/users/mitchellh \
    password=foo \
    policies=admins
```

This creates a new user "mitchellh" with the password "foo" that will be associated with the "admins" policy.

```s
vault login -method=userpass \
    username=mitchellh \
    password=foo
```
