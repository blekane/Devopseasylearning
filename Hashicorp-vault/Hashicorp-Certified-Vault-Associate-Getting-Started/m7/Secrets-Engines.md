## Using Secrets Engines
- Secrets engines are plugins used by Vault to handle sensitive data
- Secrets engines are components which store, generate, or encrypt data.

### Types of Secrets Engines
- AWS Secrets Engine [here](https://www.vaultproject.io/docs/secrets/aws): The AWS secrets engine generates AWS access credentials dynamically based on IAM policies
- Azure Secrets Engine [here](https://www.vaultproject.io/docs/secrets/azure): The Azure secrets engine dynamically generates Azure service principals along with role and group assignments
- Consul Secrets Engine [here](https://www.vaultproject.io/docs/secrets/consul): The Consul secrets engine generates Consul API tokens dynamically
- Databases [here](https://www.vaultproject.io/docs/secrets/databases): The database secrets engine generates database credentials dynamically based on configured roles
- Transform Secrets Engine: **Note:** This secret engine requires Vault Enterprise with the Advanced Data Protection Transform Module.
- KV Secrets Engine: The kv secrets engine is a generic Key-Value store used to store arbitrary secrets within the configured physical storage for Vault. 

### Dynamic vs. Static Secrets
Static secrets
- Store existing data securely
- Manual lifecycle management
- Key/Value engine

Dynamic secrets
- Generate data on demand
- Lease issued for each secret
- Automatic lifecycle management
- Majority of secrets engines
- Consul engine


### Key Value Engine Versions

**Version 1**
- No versioning, last key wins
- Faster with fewer storage calls
- Deleted items are gone
- Can be upgraded to version 2
- Default version on creation

**Version 2**
- Versioning of past secrets
- Possibly less performant
- Deleted items and metadata retained
- Cannot be downgraded
- Can be specified at creation
 
### Configuring Secrets Engines
- All engines are enabled on `/sys/mounts`
- Engines are enabled on a path
    - Defaults to engine name
- Engines can be moved
    - Revokes all existing leases
    - May impact policies
- Engines can be tuned and configured
    - Tuning settings are common for all engines
    - Configuration settings are specific to an engines

### Working with Secrets Engines
```s
# List existing secrets engines
vault secrets list

# Enable a new secrets engine
vault secrets enable [options] TYPE
vault secrets enable –path=GloboKV kv

# Tune a secrets engine setting
vault secrets tune [options] PATH
vault secrets list

# Move an existing secrets engine
vault secrets move [options] SOURCE DEST
vault secrets move GloboKV GloboKV1

# Disable a secrets engine
vault secrets disable [options] PATH
vault secrets disable GloboKV1
```

## Tasks:
- Enable secrets engines
- Configure secrets engines
- Access secrets engines

```s
# Let's first see which secrets engines are enabled
vault secrets list

# Now let's get our secrets engines enabled
# We'll start with the enabling the K/V engine
vault secrets enable -path=GloboKV -version=2 kv
vault secrets enable -path=GloboKV -version=1 kv

# Maybe we want to configure some settings for GloboKV
vault path-help /sys/mounts/GloboKV
vault secrets tune -description="Globomantics K/V version 2" GloboKV

vault secrets tune -description="AWS engine" engine
vault secrets list

# What types of things can we set on the K/V engine?
vault path-help GloboKV/

vault path-help GloboKV/config

# Why don't we check the current settings?
vault read GloboKV/config

# Let's set the max_versions to 5
vault write GloboKV/config max_versions=5

