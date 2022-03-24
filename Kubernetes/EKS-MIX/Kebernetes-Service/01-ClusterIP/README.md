### ClusterIP
- ClusterIP is the default and most common service type.
- Pods use ClusterIP to communicate together
- It is the same as the `host network` in docker
- Kubernetes will assign a cluster-internal IP address to ClusterIP service. 
- This makes the service only reachable within the cluster only.
- nobody can access this application ouside the cluster
- You cannot make requests to service (pods) from outside the cluster.
- You can optionally set cluster IP in the service definition file.

### Use Cases
- Inter service communication within the cluster. For example, communication between the `front-end` and `back-end` components of your app.


### Example
```yml
apiVersion: v1
kind: Service
metadata:
  name: my-backend-service
spec:
  type: ClusterIP # Optional field (default)
  clusterIP: 10.10.0.1 # within service cluster ip range
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 8080
```