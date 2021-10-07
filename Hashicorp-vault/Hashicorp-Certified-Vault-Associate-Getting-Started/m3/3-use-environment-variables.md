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