## Monitoring Kubernetes with Datadog [here](https://www.datadoghq.com/blog/monitoring-kubernetes-with-datadog/)

## Configure permissions and secrets
```yml
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/cluster-agent/cluster-agent-rbac.yaml"
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/cluster-agent/rbac.yaml"


kubectl create secret generic datadog-secret --from-literal api-key="<YOUR_API_KEY>"

echo -n '<32_CHARACTER_LONG_STRING>' | base64

echo -n 'a795dfap8bada83y2ac458de71bde8f9' | base64

#Use the resulting token to create a Kubernetes secret that both flavors of Agent will use to authenticate with each other:

kubectl create secret generic datadog-auth-token --from-literal=token=<TOKEN_FROM_PREVIOUS_STEP>

kubectl create secret generic datadog-auth-token --from-literal=token=YTc5NWRmYXA4YmFkYTgzeTJhYzQ1OGRlNzFiZGU4Zjk=
```