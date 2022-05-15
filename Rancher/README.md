
## Rancher installation
```
helm repo add rancher \
    https://releases.rancher.com/server-charts/stable

helm repo update

helm upgrade --install \
    rancher rancher/rancher \
    --namespace cattle-system \
    --create-namespace \
    --set hostname=$RANCHER_ADDR \
    --set ingress.tls.source=letsEncrypt \
    --set letsEncrypt.email=$EMAIL \
    --wait
```