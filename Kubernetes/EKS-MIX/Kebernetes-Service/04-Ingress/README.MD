## Overview on Kubernetes Ingress [here](https://www.golinuxcloud.com/steps-to-expose-services-using-kubernetes-ingress/)

Kubernetes offers an ingress resource and controller that is designed to expose Kubernetes services to the outside world. It can do the following:
- Provide an externally visible URL to your service
- Load balance traffic
- Terminate SSL
- Provide path base rathing
- it exposes all service in kubernetes clust

Ingresses do not work like other Services in Kubernetes. Just creating the Ingress itself will do nothing. You need two additional components:

- An Ingress controller: you can choose from many implementations, built on tools such as - Nginx or HAProxy.
- ClusterIP or NodePort Services for the intended routes.