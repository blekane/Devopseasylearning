
# LoadBalancer
- LoadBalancer service is an extension of `NodePort service`. NodePort and ClusterIP - Services, to which the external load balancer routes, are automatically created. The cloud provider automatically assig you a public IP
- This is only available in the cloud and not on premisse
- It integrates NodePort with cloud-based load balancers.
- It exposes the Service externally using a cloud provider’s load balancer.
- Each cloud provider (AWS, Azure, GCP, etc) has its own native load balancer implementation. The cloud provider will create a load balancer, which then automatically routes requests to your Kubernetes Service.
- Traffic from the external load balancer is directed at the backend Pods. The cloud - provider decides how it is load balanced.
- Every time you want to expose a service to the outside world, you have to create a new LoadBalancer and get an external IP address.
- The application will be accessible on every node in the cluster using that external IP address.

### Use Cases
When you are using a cloud provider to host your Kubernetes cluster.


### Example
```yml
apiVersion: v1
kind: Service
metadata:
  name: my-frontend-service
spec:
  type: LoadBalancer
  clusterIP: 10.0.171.123
  loadBalancerIP: 123.123.123.123
  selector:
    app: web
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 8080
```


### Apache packaged by Bitnami [here](https://bitnami.com/stack/apache/helm)
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/apache
```

### NGINX Open Source packaged by Bitnami [here](https://bitnami.com/stack/nginx/helm)
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/nginx
```

### Install Argo CD [here](https://argo-cd.readthedocs.io/en/stable/getting_started/)

**NB:** edit the service of `argo-server` and put `LoadBalancer` so that you can access the application because ArgoCD with come with `NodePort` by default
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```