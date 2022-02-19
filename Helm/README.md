### Helm Documentation Links

* [kubeapps app](https://hub.kubeapps.com/)

* [Helm Charts Github](https://github.com/helm/charts/tree/master/stable)

* [Helm release](https://github.com/helm/helm/releases)

* [Helm Website](https://helm.sh/)

* [Quickstart Guide](https://helm.sh/docs/intro/quickstart/)

* [phcollignon/helm3](https://github.com/phcollignon/helm3)

* [Find, install and publishKubernetes packages](https://artifacthub.io/)

* [Helm Public Respository](https://artifacthub.io/)

* [Helm chart stable repository](https://github.com/viveksinghggits/charts/tree/master/stable)

## Function
[Sprig Function Documentation](http://masterminds.github.io/sprig/)
[Template Functions and Pipelines](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/)


### 
**Helm 3**
```
helm install --dry-run --debug ./[chart folder name] --generate-name
helm install --dry-run --debug ./mychart --generate-name
```

**Helm 2**
```
helm install --dry-run --debug ./[chart folder name]/ --name [release name]
helm install --dry-run --debug ./mychart/ --name demo
```