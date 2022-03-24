### ExternalName
- Services of type ExternalName map a Service to a DNS name, not to a typical selector - such as my-service.
- You specify these Services with the `spec.externalName` parameter.
- It maps the Service to the contents of the externalName field (e.g. foo.bar.example.com)- , by returning a CNAME record with its value.
- No proxying of any kind is established.

### Use Cases
- This is commonly used to create a service within Kubernetes to represent an external - datastore like a database that runs externally to Kubernetes.
- You can use that ExternalName service (as a local service) when Pods from one namespace - to talk to a service in another namespace.

### Example
```yml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ExternalName
  externalName: my.database.example.com
```