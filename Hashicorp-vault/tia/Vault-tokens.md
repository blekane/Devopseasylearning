## Vault Tokens
- Tokens [here](https://www.vaultproject.io/docs/concepts/tokens)
- Token types [here](https://learn.hashicorp.com/tutorials/vault/tokens)

- Root tokens can do ANYTHING
- Do not expire
- Created in three ways
    - Initialize Vault server
    - Existing root token
    - Using operator command

### Working with Tokens
```s
# Create a new token
vault token create [options]
vault token create –policy=my-policy –ttl=60m

# View token properties
vault token lookup [options] [ ACCESSOR | ID ]
vault token lookup -accessor FJkyU35ihsMf3nKOLWdOUqdY

# Check capabilities on a path
vault token capabilities TOKEN PATH
vault token capabilities s.TG9U2ZdtPU1Hmz18BcujrETI secrets/apikeys/
```

Tasks:
- Create Vault service token
- Obtain tokens from auth methods
- Create a batch token
- Renew and revoke tokens
- Create a periodic token

### Login into Vault using the root token
```
vault login $root_token
```

### First we are going to create a basic token
- this will be a child token od the root token
- ttl = time to live. This the time that we can use the token before it expire
- We can onliy use the root token to create an orphan token
```
vault token create -policy=default -ttl=60m
```

### Now let's check out some info on the token
```
vault token lookup TOKEN_VALUE
vault token lookup s.MyiaYGmyYCtLuY8D6rpWryGy 
```
```
Key                 Value
---                 -----
accessor            SFDflnJh8MrMMocG0niz5ABY
creation_time       1633860396
creation_ttl        1h
display_name        token
entity_id           n/a
expire_time         2021-10-10T11:06:36.109577019Z
explicit_max_ttl    0s
id                  s.J40g1W7qWNuUvg0xnnUajc8j
issue_time          2021-10-10T10:06:36.109580356Z
meta                <nil>
num_uses            0
orphan              false
path                auth/token/create
policies            [default]
renewable           true
ttl                 56m47s
type                service
```

### We can do the same using the accessor, but no ID
- We will not see the vault ID when we use the accessor
- The root ID will be display if we lookup the root ID
```
vault token lookup -accessor ACCESSOR_VALUE
vault token lookup -accessor SFDflnJh8MrMMocG0niz5ABY
```

### Now let's revoke our token
```
vault token revoke -accessor ACCESSOR_VALUE
vault token revoke -accessor SFDflnJh8MrMMocG0niz5ABY
```

## Service or Batch
When we create a token, it is a service token by default.
Service:
- Fully featured, heavyweight
- Managed by accessor or ID
- Written to persistent storage
- Calculated lifetime
- Renewable if desired
- Can create child tokens
- Default type for most situations
- **Begins with "s." in ID**: `s.J40g1W7qWNuUvg0xnnUajc8j`

Batch: 
- Limited features, lightweight
- Has no accessor
- Not written to storage
- Static lifetime
- Never renewable
- No child tokens
- Explicitly created
- **Begins with "b." in ID**: `b.AAAAAQLQbyKsJJnnk1fnhNv4GRbKLXZy5`


### Now we'll create a batch token with a ttl of 30m
```
vault token create -type=service -policy=default -ttl=30m
vault token create -type=batch -policy=default -ttl=30m
```
```
Key                  Value
---                  -----
token                b.AAAAAQLQbyKsJJnnk1fnhNv4GRbKLXZy5WBXdVv6SeiOJxx3LQ9ICViVYh8j8lSsI4bBXHzdWS9ZOWO31qtntqMnfeTYP1Maw7ipFNqGPqqLO7fG_jDmMnCvP_7ZVwWNcpTzsfm1svsKOPSAVEw1uVKBTlk3t_g
token_accessor       n/a
token_duration       30m
token_renewable      false
token_policies       ["default"]
identity_policies    []
policies             ["default"]
```

### Let's try to lookup the properties of a batch token
```
batch_id=BATCH_TOKEN_ID
batch_id=b.AAAAAQLQbyKsJJnnk1fnhNv4GRbKLXZy5WBXdVv6SeiOJxx3LQ9ICViVYh8j8lSsI4bBXHzdWS9ZOWO31qtntqMnfeTYP1Maw7ipFNqGPqqLO7fG_jDmMnCvP_7ZVwWNcpTzsfm1svsKOPSAVEw1uVKBTlk3t_g

vault token lookup $batch_id
```
### It's not an orphan and it cannot be renewed
```
vault token renew $batch_id
```

### Token Lifetime
- Token TTL
- Max TTL
- Token renewal
- Periodic token

### Token TTL properties
- creation_time: Unix time `1613828388` 
- creation_ttl: TTL set at creation `30m`
- expire_time: Project expiration time `2021-02-20T09:09:48.4036711-05:00`
- explicit_max_ttl 0s: Max TTL if set
- issue_time: Friendly creation time `2021-02-20T08:39:48.4036711-05:00` 
- ttl 29m13s: TTL value

### Working with Token Lifetime
```s
# Renew the currently authenticated token 
vault token renew

# Renew a token
vault token renew [TOKEN_ID OR ACCESSOR_ID]
vault token lookup s.MyiaYGmyYCtLuY8D6rpWryGy

# Renew a token requesting a specific increment value
vault token renew [options] [ACCESSOR | ID ] [ -increment=<duration> ]
vault token create -policy=default -ttl=30m
vault token renew -increment=60m s.MyiaYGmyYCtLuY8D6rpWryGy 
vault token lookup s.MyiaYGmyYCtLuY8D6rpWryGy
```

### MAX TTL
- The system max ttl is 32 days by default.
- If we create a token with the max ttl more that 32 days, the vault we accept it and we will not be able to login with that token unitill we increment the default vault.
- You cannot create a token with the max ttl greather than the default
```s
# We are going to try setting max ttl from the mount and user
# Start by enabling the max ttl for userpass to 33 days (776h)

# Enable userpass auth method
vault auth enable -max-lease-ttl=776h userpass

# Now we are going to try and configure a user with a great max ttl of 784h
# Note: Vault will let you do this, but it won't honor it.
2822400s = 784h = 34 days
vault write auth/userpass/users/ned token_max_ttl=2822400 password=tacos

# Let's try logging in as Ned and renewing our token for 34 days (784h)
vault login -method=userpass username=ned

vault token renew -increment=784h

WARNING! The following warnings were returned from Vault:

  * TTL of "784h" exceeded the effective max_ttl of "775h56m31s"; TTL value is
  capped accordingly

Key                    Value
---                    -----
token                  s.UbQIjHzxVmYtFNhOcCxZyZ3D
token_accessor         uVduuHc0XLgDcLiUjHRTIFJ3
token_duration         775h56m31s
token_renewable        true
token_policies         ["default"]
identity_policies      []
policies               ["default"]
token_meta_username    ned

# If we changed the max TTL on the mount to 784h, then Vault would honor 

# Now we can revoke our own token if we're done with our work
# This is to revoke a token that we login with
vault token revoke -self
vault token lookup
```

### Change token time-to-live (TTL) on Hashicorp Vault [here](https://medium.com/@azsecured/change-token-time-to-live-ttl-on-hashicorp-vault-52f1bef6ca62)
```s
#Create token for test policy:
vault token create --policy=test

#Show default default_lease_ttl and max_lease_ttl values. token_duration is 768h.
vault read sys/auth/token/tune

#Change default values to 9000h for 1 year
vault write sys/auth/token/tune max_lease_ttl=9000h
vault write sys/auth/token/tune default_lease_ttl=9000h

#Now again create token for test policy. token_duration is changed.
vault token create --policy=test

#Also can set custom TTL for token with period parameter. token_duration is 5000h.
vault token create --policy=test -period=5000h
```

### Periodic Tokens
- Does not expire (no max TTL)
- Must be renewed based on period
- TTL set to period at creation and renewal
- Requires sudo privileges to create
- Explicit max TTL can be applied

**Use Case:**
- Database system will use token for secrets access
- System does not support dynamically changing the token value

**Use Case:**
- Create a periodic token for the database system to use
- Script a process to renew the token at the necessary interval

```s
# What about a periodic token? Let's create one of those
vault token create -policy=default -period=2h

# And take a look at its properties
vault token lookup PERIODIC_TOKEN_ID
vault token lookup s.Hea55YZu10GRBa5S0BOLlnib

# Now let's try to renew
vault token renew -increment=180m PERIODIC_TOKEN_ID
vault token renew -increment=180m s.Hea55YZu10GRBa5S0BOLlnib

Key                  Value
---                  -----
token                s.Hea55YZu10GRBa5S0BOLlnib
token_accessor       uujickODWqEInlkkQZzo0YDm
token_duration       2h
token_renewable      true
token_policies       ["default"]
identity_policies    []
policies   

# Looking at the properties again, the ttl is back to 2h
# If you supply an increment, Vault ignores it beacse we set the period already. The token can only be renew at that time. We can write a script to renew it at that time
```

### Token Hierarchy
- Child tokens are created by a parent token
- Batch tokens cannot create children
- Protects against escaping revocation
- Orphan tokens have no parent token
    - Explicit creation
    - Auth methods
    - Orphaned by parent

### Parent Child Token Hierarchy [here](https://support.hashicorp.com/hc/en-us/articles/360034820694-Parent-Child-Token-Hierarchy)

```s
#Create Initial (Parent) Token
vault token create -policy=example-token-create -ttl=5m

#Login with Parent Token and Create Second (Child) Token
vault token create -ttl=15m 

#Login with Child Token and Perform Token Lookup
vault token lookup

A lookup of the token shows 13 minutes, 18 seconds remaining; your time will differ, but it will certainly be greater than 5 minutes 

Now, wait about 4 minutes and try again:
The parent token (the one with the TTL of 5 minutes) expired, and since the child token we created was a child of that token it was also revoked even though we specified 15 minutes for its TTL.
```

### Orphan tokens [here](https://learn.hashicorp.com/tutorials/vault/tokens)
- Orphan tokens are not children of their parent; therefore, orphan tokens do not expire when their parent does.
- We can orphan a child token so that it will not expire when the parent token does.

**NOTE:** Orphan tokens still expire when their own max **TTL** is reached.
```
vault token create -orphan
```

```s
vault write auth/token/roles/zabbix \
    allowed_policies="policy1, policy2, policy3" \
    orphan=true \
    period=8h
```

### Key Takeaways
- Tokens are the fundamental way of interacting with Vault. Can be issued through auth methods, operator command, or other tokens.
- Root tokens can do ANYTHING. Requires unseal or recovery keys to create. Should be revoked as soon as possible.
- Accessors are used to manage tokens without having access to their ID or permitted actions.
- Service tokens are the default and persistently stored. Batch tokens are limited, ephemeral, and are used for high-volume applications.
- Token TTL is the amount of time a token is valid for. Tokens can be renewed for additional time within the effective max TTL.
- Periodic tokens can be renewed forever based on a period TTL. Require elevated permissions and may have an explicit max TTL.
- Tokens have a hierarchy of parent/child. Revoking a parent token revokes the children by default. Orphaned tokens have no parent