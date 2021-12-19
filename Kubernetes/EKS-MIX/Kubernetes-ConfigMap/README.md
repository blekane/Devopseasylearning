### ConfigMap
- it stand for configuration map. It use to store non sentitive data in kubernetes in the form of key pair
- we can also add a script in the ConfigMap and mount that script as a volume in the container
- non sentitive data are name, email, labels
- A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pod can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume 

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  creationTimestamp: 2016-02-18T18:52:05Z
  name: game-config
  namespace: default
  resourceVersion: "516"
  uid: b4952dc3-d670-11e5-8cd0-68f728db1985
data:
  game.properties: |
    enemies=aliens
    lives=3
    enemies.cheat=true
    enemies.cheat.level=noGoodRotten
    secret.code.passphrase=UUDDLRLRBABAS
    secret.code.allowed=true
    secret.code.lives=30    
  ui.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true
    how.nice.to.look=fairlyNice  
```

ConfigMap – Kubernetes Example with YAML [here](https://matthewpalmer.net/kubernetes-app-developer/articles/configmap-example-yaml.html)
```yaml
kind: ConfigMap 
apiVersion: v1 
metadata:
  name: example-configmap 
data:
  # Configuration values can be set as key-value properties
  database: mongodb
  database_uri: mongodb://localhost:27017
  
  # Or set as complete file contents (even JSON!)
  keys: | 
    image.public.key=771 
    rsa.public.key=42
```


```yml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: kube-system
  name: aws-iam-authenticator
  labels:
    k8s-app: aws-iam-authenticator
data:
  config.yaml: |
    clusterID: kops.jomo.click
    server:
      mapRoles:
      - roleARN: arn:aws:iam::617960797257:role/kubernetes_readonly_users_role
        username: kubernetes_readonly_users_role
        groups:
        - kubernetes-readonly-users
      mapUsers:
      - userARN: arn:aws:iam::617960797257:user/tf-test-developers1
        username: tf-test-developers1
        groups:
        - system:masters
      - userARN: arn:aws:iam::617960797257:user/robin-kops-aws-test
        username: robin-kops-aws-test
        groups:
        - system:masters
```