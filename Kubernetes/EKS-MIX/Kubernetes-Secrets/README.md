### Secret [here](https://kubernetes.io/docs/concepts/configuration/secret/)
- Kubernetes Secrets let you store and manage `sensitive information`, such as passwords, OAuth tokens, and ssh keys. Storing confidential information in a Secret is safer and more flexible than putting it verbatim in a Pod definition or in a container image. 
- A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key. Such information might otherwise be put in a Pod specification or in an image. Users can create Secrets and the system also creates some Secrets.

**Caution:**
Kubernetes Secrets are, by default, `stored as unencrypted base64-encoded strings`. By default they can be retrieved - as plain text - by anyone with API access, or anyone with access to Kubernetes' underlying data `store`, etcd. In order to safely use Secrets, it is recommended you (at a minimum):
  - Enable Encryption at Rest for Secrets.
  - Enable or configure RBAC rules that restrict reading and writing the Secret. Be aware that secrets can be obtained implicitly by anyone with the permission to create a Pod.

SSH authentication secrets
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-ssh-auth
type: kubernetes.io/ssh-auth
data:
  # the data is abbreviated in this example
  ssh-privatekey: |
          MIIEpQIBAAKCAQEAulqb/Y ...
```

Service account token Secrets
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-sa-sample
  annotations:
    kubernetes.io/service-account.name: "sa-name"
type: kubernetes.io/service-account-token
data:
  # You can include additional key value pairs as you do with Opaque Secrets
  extra: YmFyCg==
```