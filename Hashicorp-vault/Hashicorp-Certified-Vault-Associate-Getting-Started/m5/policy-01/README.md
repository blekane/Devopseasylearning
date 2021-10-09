# Vualt policies
- Default policy: it is the default policy that is created when the vault start up. You can edit the default policy, but you cannot delete it.
- Root policy: it is the default policy that is assign to the root token. It has full control in the vault server. You cannot edit the default policy, and you cannot delete it.

## Policy Syntax
- HCL OR JSON: this is the language used to write a policy
- Path: this is where to store a policy
- capabilities: this is the privilege of what you can do 

### Path Examples
```s
# Basic path expression
path "somepath/in/vault"

# Using the glob '*'
# Match "secrets/globo/web1/" and "secrets/globo/webapp/apikeys"
path "secrets/globo/web*"

# Using the path segment match '+'
# Match "secrets/globo/webapp1/apikeys" and "secrets/globo/webapp2/apikeys"
path "secrets/globo/+/apikeys"
```

### Capability Examples
```s
# Allow read access to an apikey
path "secrets/globo/webapp/apikey" {
capabilities = ["read"]
}

# Allow read and list access to webapp path
path "secrets/globo/webapp/*" {
capabilities = ["read","list"]
}

# Allow full access to apikey in globo paths
path "secrets/globo/+/apikey" {
capabilities = ["create","read","update","delete"]
}

# Deny access to the globo privileged path
path "secrets/globo/webapp/*" {
capabilities = ["create","read","list","update","delete"]
}

path "secrets/globo/webapp/privileged*" {
capabilities = ["deny"]
}
```

### Working with Policies

```s
# List existing policies
vault policy list

# Read the contents of a policy
vault policy read [options] NAME
vault policy read secrets-mgmt

# Write a new policy or update an existing policy
vault policy write [POLICY NAME] [NAME PATH] 
vault policy write secrets-mgmt secrets-mgmt.hcl

# Delete a policy
vault policy delete [options] NAME
vault policy delete secrets-mgmt

# Format a policy per HCL guidelines
vault policy fmt [options] PATH
vault policy fmt secrets-mgmt.hcl
```

### Tasks:
- Create two policies
- Generate a token with a policy
- Update a policy
- Delete a policy

## Example
```s
# Now we can check and see what policies exist right now
vault policy list 

# Enable userpass auth method
vault auth enable userpass

# Add a user
vault write auth/userpass/users/ned password=tacos

# Now we'll create a policy for secrets management
# mounts: it the path that vault uses to mount all the policies
vim secrets-mgmt.hcl

path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "sys/mounts"
{
  capabilities = ["read"]
}

vault policy write [name of the policy] [path of the policy].hcl
vault policy write secrets-mgmt ./secrets-mgmt.hcl
vault policy list
vault policy read secrets-mgmt
vault policy delete secrets-mgmt

# Next we'll create a policy for the accounting secrets engine
# First we'll enable the secrets engine
vault secrets enable -path=accounting -version=2 kv

# And we'll add some secrets to the engine
vault kv put accounting/apitokens/d101 token=1234567890
vault kv put accounting/apitokens/d102 token=1234567890
vault kv put accounting/apitokens/d103 token=1234567890
vault kv put accounting/apitokens/privileged/p101 token=1234567890

# Now we can craft a policy allowing access to the regular tokens
# And denying access to the priveleged tokens


vim accounting.md.hcl

path "accounting/data/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}
path "accounting/metadata/*" {
    capabilities = ["list"]
}
path "accounting/data/apitokens/privleged*" {
    capabilities = ["deny"]
}
path "accounting/metadata/apitokens/privileged*" {
    capabilities = ["deny"]
}

vault policy write [name of the policy] [path of the policy].hcl
vault policy write accounting ./accounting.hcl
vault policy list
vault policy read accounting
vault policy delete accounting
```
## Assigning a Policy to a token

```sh
# Associate directly with a token
vault token create –policy="secrets-mgmt"

# Assign to a user in userpass
vault write auth/userpass/users/ned token_policies="secrets-mgmt"

# Assign to an entity in identity
vault write identity/entity/name/ned policies="secrets-mgmt"
```

```sh
# First let's try out our accounting policy be associating a policy
# directly with a token
vault token create -policy=accounting

# Now log in with that token
vault login

# We'll try listing out info in the accounting secrets engine
vault kv list accounting/

vault kv list accounting/apitokens/

vault kv list accounting/apitokens/privileged

# Seems to work for listing, let's try reading some secrets
vault kv get accounting/apitokens/d101

vault kv get accounting/apitokens/privileged/p101

# Uh, oh. Looks like we messed something up. Better update that policy to fix it.
# We can do that through the UI or with this command (You'll need to log back in as root)
vault policy write accounting accounting-fixed.hcl

vault kv get accounting/apitokens/privileged/p101

# Excellent! Next we're going to test out out secrets-mgmt policy
# We are going to assign it to Ned in the userpass auth method
```


## We are going to assign a policy to Ned in the userpass auth method
```sh
# Looks like token_policies should do it
vault write auth/userpass/users/ned token_policies="secrets-mgmt"

# Now we can log in as Ned and try to mount a new secrets engine
vault login -method=userpass username=ned

vault secrets enable -path=testing -version=1 kv

vault secrets list

vault secrets disable testing

vault secrets disable accounting

# Lastly, let's get rid of the accounting policy
vault policy delete accounting

# Wait, Ned can't do that! Let's log in as root again
vault login
```