## Kubernetes-Datadog

1. Install kubernetes integration in datadog

2. create a value file in the cluster [here](https://github.com/DataDog/helm-charts/blob/main/charts/datadog/values.yaml)

3. Create a namespace 
```
kubectl create ns datadog
```

4. install the helm chart [here](https://docs.datadoghq.com/agent/kubernetes/?tab=helm)

```
helm repo add datadog https://helm.datadoghq.com
helm repo update
```

Helm v3+
```
helm install <RELEASE_NAME> -f values.yaml  --set datadog.apiKey=<DATADOG_API_KEY> datadog/datadog --set targetSystem=<TARGET_SYSTEM>

helm install datadog-agent -f values.yaml  --set datadog.apiKey=a795dfaa4daea83b2ad458de71bde5f9 datadog/datadog --set targetSystem=linux --name
```


