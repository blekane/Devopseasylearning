### Grafana Installation
* [How to install and configure Grafana on CentOS 7](https://www.fosslinux.com/8328/how-to-install-and-configure-grafana-on-centos-7.htm)

* [Grafana fundamentals](https://grafana.com/tutorials/grafana-fundamentals/?utm_source=grafana_gettingstarted#5)

### Grafana Installation in CentOS 7

https://www.fosslinux.com/8328/how-to-install-and-configure-grafana-on-centos-7.htm

Username: admin
Password: 12345

http://10.0.0.3:3000/

### Grafana fundamentals
https://grafana.com/tutorials/grafana-fundamentals/?utm_source=grafana_gettingstarted#5

### Grafana Installation in Docker
https://hub.docker.com/r/grafana/grafana

```
docker run -d --name=grafana -p 3000:3000 grafana/grafana
docker run -d --name=grafana -p 3050:3000 grafana/grafana

Username: admin
Password: admin
```
### Links to install promtheus Helm chart into Kubernetes Cluster
* [DEPRECATED prometheus-operator link](https://github.com/helm/charts/tree/master/stable/prometheus-operator)

* [kube prometheus stack stable link](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)

### Install prometheus-operator DEPRECATED version

* add repos
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
```


* install chart
```
helm install [release name] stable/prometheus-operator -n [namespace]
helm install prometheus-operator-stack-helm stable/prometheus-operator -n v15
```

### Install kube-prometheus-stack
**Prerequisites:**
- Kubernetes 1.16+
- Helm 3+

```
helm install [release name] prometheus-community/kube-prometheus-stack

helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack
```

* If having issue is from previous installations of other prometheus-relevant manifest files. As defined in the uninstallation guide, delete the following:
```
kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
```