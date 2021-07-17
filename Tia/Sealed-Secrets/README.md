# Sealed Secrets

[Sealed Secret controller Cluster-Side section of the installation instructions](https://github.com/bitnami-labs/sealed-secrets/releases)

[kubeseal client-side utility installation instructions](https://github.com/bitnami-labs/sealed-secrets/releases)

[Sealed secret stable helm chart](https://github.com/bitnami-labs/sealed-secrets)

### Install client-side tool into /usr/local/bin/ (Client side)
```sh
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.16.0/kubeseal-linux-amd64 -O kubeseal
sudo install -m 755 kubeseal /usr/local/bin/kubeseal
```

### Install server-side tool (Cluster side)
```
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.16.0/controller.yaml
```

### How to generate a secrets?
```
echo -n <password> | kubeseal --raw --from-file=/dev/stdin --scope cluster-wide --cert <cert>.pem
OR
echo -n <password> | kubeseal --raw --from-file=/dev/stdin --scope cluster-wide --cert <cert>.pem
OR
echo -n <password> | kubeseal --raw --from-file=/dev/stdin --scope cluster-wide #if you have a session open with corresponding cluster

echo -n foo | kubeseal --raw --from-file=/dev/stdin --namespace bar --name mysecret
echo -n foo | kubeseal --raw --from-file=/dev/stdin --namespace bar --scope namespace-wide
echo -n foo | kubeseal --raw --from-file=/dev/stdin --scope cluster-wide
```