[here](https://github.com/btkrausen/hashicorp)
https://github.com/ned1313/Hashicorp-Certified-Vault-Associate-Vault-Management
https://github.com/ned1313/Hashicorp-Certified-Vault-Associate-Getting-Started
## What is Vault?
- Manage Secrets and Protect SensitiveData
- Provides a Single Source of Secrets for both Humans and Machines
- Provides Complete Lifecycle Management for Secrets
- Securely store any secret
- Provide governance for access to secrets

## What is a Secret?
- Anything your organization deems sensitive:
    - Usernames and passwords
    - Certificates
    - API keys 
    - Encryption Keys

## Why Organizations Choose Vault
![](/images/vault1.JPG)

## Why Organizations Choose Vault
![](/images/vault2.JPG)

## Use Case –Storage of Secrets
![](/images/vault3.JPG)

## Vault –Compare Versions
![](/images/vault4.JPG)

## Vault –Open Source
Includes:
- Incredible number of features and integrations
- Local high-availability by way of clustering
- Almost all secrets engines and auth methods
- Can easily integrate with any application using fully-featured API

Does Not Include:
- No Replicationcapabilities = single datacenter/cloud deployment
- Does not include access to Enterprise integrations (MFA, HSM, Automated Backups)
- Limited Scalability

## Vault –Enterprise
Includes:
- Access to all* features and functions Vault offers
- Replication capabilities to other Vault clusters across datacenters/clouds
- All secrets engines and auth methods
- Can easily integrate with any application using fully-featured API
- Namespaces for multi-tenancy solution
- Policy as Code using Sentinel
- Easily scale local reads using Performance Standbys
- Access to the Raft/Consul snapshot agent for automated disaster recovery solution

Does Not Include:
- Self-Managed -Not hosted or managed by HashiCorp

## Vault on HashiCorp Cloud Platform (HCP)
- All features of Vault Enterprise
- Fully managed solution
- Click button deployment
- HashiCorp team of Vault experts manages and upgrades your cluster(s)
![](/images/vault5.JPG)

## Vault Architecture
![](/images/vault6.JPG)

## Seal and Unseal
- Vault starts in a **sealed state**, meaning it knows where to access the data, and how, but can’t decrypt it
- Almost no operations are possible when Vault is in a sealed state (only status check and unsealing are possible)
- Unsealing Vault means that a node can reconstruct the master key in order to decrypt the encryption key, and ultimately and read the data
- After unsealing, the **encryption key is stored in memory**
- Sealing Vault means Vault “throws away” the encryption key and requires another unseal to perform any further operations
- Vault will start in a sealed state –you can also manually seal it via **UI, CLI, or API**
- When would I seal Vault?
    - Key shards are inadvertently exposed
    - Key expose on VCS
    - Detection of a compromise or network intrusion
    - Spyware/malware on the Vault nodes

## Unsealing with Key Shards
- Default option for unsealing –no configuration needed
- **No single person** should have access to all key shards
- Ideally, each key shard should be stored by a **different** employee
    - The downsite of this is that if the vault restart at night, you will have to wake up 3 people in your organisation to unseal it
    - This is because the vault starts in seal state and we need to reconstruct the master key
    - if we restart the vault, we will need to unseal it
- When initializing Vault, you can request the individual shards to be encrypted with different **PGP keys**
- When unsealing Vault, you will need an **equal number** of employees to provide their key which is equal to the threshold
- Key shards should not be stored online and should be highly protected –ideally stored encrypted

## Installing Vault
- Vault is platform agnostic. meaning it can be run on many different underlying platforms
    - Kubernetes
    - Cloud-based Machines (AWS Instances, Azure Virtual Machines)
    - VMware Virtual Machines
    - Physical Servers
    - A Laptop

Vault is also available for many operating systems
- macOS
- Windows
- Linux
- FreeBSD
- NetBSD
- OpenBSD
- Solaris

Order of Operations:
1. Install Vault
2. Create Configuration File
3. Initialize Vault
4. Unseal Vault

So where do I download Vault?
- vaultproject.io [here](https://www.vaultproject.io/)
- releases.hashicorp.com/vault [here](https://releases.hashicorp.com/vault/)
- You can also download/install Vault using your preferred package manager as well (apt, yum, even homebrew) [here](https://www.vaultproject.io/downloads)
```
$ curl -fsSLhttps://apt.releases.hashicorp.com/gpg | sudo apt-key add -
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release-cs) main"
$ sudo apt-get update && sudo apt-get install vault
```
- Use the Vault Helm Chart to install/configure Vault on Kubernetes [here](https://www.vaultproject.io/docs/platform/k8s/helm)
```sh
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault

## List the available releases
$ helm search repo hashicorp/vault -l
NAME            CHART VERSION   APP VERSION DESCRIPTION
hashicorp/vault 0.16.1          1.8.3       Official HashiCorp Vault Chart
hashicorp/vault 0.16.0          1.8.2       Official HashiCorp Vault Chart
hashicorp/vault 0.15.0          1.8.1       Official HashiCorp Vault Chart
hashicorp/vault 0.14.0          1.8.0       Official HashiCorp Vault Chart
hashicorp/vault 0.13.0          1.7.3       Official HashiCorp Vault Chart
hashicorp/vault 0.12.0          1.7.2       Official HashiCorp Vault Chart
hashicorp/vault 0.11.0          1.7.0       Official HashiCorp Vault Chart
hashicorp/vault 0.10.0          1.7.0       Official HashiCorp Vault Chart

# Install version 0.16.1
$ helm install vault hashicorp/vault --version 0.16.1
```

## Installing Vault on 
```sh
wget https://releases.hashicorp.com/vault/1.7.1/vault_1.7.1_linux_amd64.zip
unzip vault_1.7.1_linux_amd64.zip
sudo mv vault /usr/local/bin/

# Test if the vault command is working
vault
vault --version
```
## Where Would I Use Dev Server?
- New Development Integrations
- Testing New Features of Vault
- Experimenting with Features

## Running Vault Dev Server
![](/images/vault8.JPG)

```
vault server -dev
```
```sh
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: h9jyg5imdu6dbIazOawsM2YPo8WaZ5ej2XI7RQP00WU=
Root Token: s.iNDOcXVwVGxerslP2fGJogUD

Development mode should NOT be used in production installations!
```

```sh
# Export variable
# Storage Type is in momeroy. This means we will loose all the data that we put into a vault as soon as we close out the terminal
root@ubuntu:~# export VAULT_ADDR='http://127.0.0.1:8200'
root@ubuntu:~# vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.7.1
Storage Type    inmem
Cluster Name    vault-cluster-a801ec7d
Cluster ID      a623c81a-9dcc-b77a-b15f-11b4379fd384
HA Enabled      false
```
```sh
# list secrets
root@ubuntu:~# vault secrets list
Path          Type         Accessor              Description
----          ----         --------              -----------
cubbyhole/    cubbyhole    cubbyhole_17be818a    per-token private secret storage
identity/     identity     identity_b26882f1     identity store
secret/       kv           kv_a44baad2           key/value secret storage
sys/          system       system_5d14da6e       system endpoints used for control, policy and debugging
```

## Running Vault Server in Production
- Deploy one or more persistent nodes via **configuration file**
- Use a **storage backend** that meets the requirements
- Multiple Vault nodes will be configured as a cluster
- Deploy close to your applications
- Most likely, you’ll **automatethe** provisioning of Vault

- To start Vault, run the vault server `–config=<file>` command
- In a production environment, you'll have a service manager executing and managing the Vault service (systemctl, Windows Service Manager, etc.)
- For Linux, you also need a `systemd file` to manage the service for Vault (and Consulif you're running Consul)

### Modes
- Systemd for a Vault service: [here](https://github.com/btkrausen/hashicorp/blob/master/vault/config_files/vault.service)
- Systemd file for a Consul Server: [here](https://github.com/btkrausen/hashicorp/blob/master/consul/consul.service)
- Systemd for a Consul client (that would run on the Vault node): [here](https://github.com/btkrausen/hashicorp/blob/master/vault/config_files/consul-client.json)

### Single Node
![](/images/vault9.JPG)

### Multi-Node Vault Cluster (with Integrated Storage)
Each one of this nodes is going to have it own configuiration file, storage and TLS

![](/images/vault10.JPG)

### Multi-Node Vault Cluster (with external storage backend)
Each one of this nodes is going to have it own configuiration file, storage and TLS
![](/images/vault11.JPG)

### Step-by-Step Manual Install
1. Download Vault from HashiCorp
2. Unpackage Vault to a Directory
3. Set Path to Executable
4. Add Configuration File & Customize
5. Create Systemd Service File
6. Download Consul from HashiCorp
7. Configure and Join Consul Cluster
8. Launch Vault Service



vault status