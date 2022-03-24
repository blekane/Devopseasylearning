### NodePort
- it mostly use for on premise K8S and not cloud
- NodePort service is an extension of ClusterIP service. A ClusterIP Service, to which the - NodePort Service routes, is automatically created.
- It exposes the service outside of the cluster by adding a cluster-wide port on top of ClusterIP.
- NodePort exposes the service on each Node’s IP at a static port (the NodePort)
- You can contact the NodePort Service, from outside the cluster, by requesting - <NodeIP>:<NodePort>.
- Node port must be in the range of 30000–32767. Manually allocating a port to the service - is optional. If it is undefined, Kubernetes will automatically assign one.
- If you are going to choose node port explicitly, ensure that the port was not already - used by another service.

### Use Cases
- it mostly use for on premise K8S and not cloud
- When you want to enable external `connectivity to your service`.
- Using a NodePort gives you the freedom to set up your own load balancing solution, to configure environments that are not fully supported by Kubernetes, or even to expose one or more nodes’ IPs directly.



### Example
```yml
apiVersion: v1
kind: Service
metadata:
  name: my-frontend-service
spec:
  type: NodePort
  selector:
    app: web
  ports:
  - name: http
    protocol: TCP
    port: 80 # Port open on the pod
    targetPort: 8080 # (port open on the container)
    nodePort: 30000 # 30000-32767, Optional field (port open on the node). This number can be changed and it have to be 5 digit
```