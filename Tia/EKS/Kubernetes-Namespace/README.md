# Kubernetes Namespace
You may have heard about Linux namespace which are used to isolate system processes from each other. In a similar concept we have namespace in Kubernetes which can provide a scope for objects names. We will learn more about Kubernetes namespace in this session.

## Understanding Kubernetes Namespaces
- Kubernetes uses namespaces to organize objects in the cluster.
- You can think of each namespace as a folder that holds a set of objects.
- Namespace implements strict resource separation
- Use namespaces to separate customer environments within one Kubernetes cluster
- By default, the `kubectl` command-line tool interacts with the default namespace.
- If you want to use a different namespace, you can pass kubectl the `--namespace flag`.
- For example, `kubectl --namespace=mystuff` references objects in the mystuff namespace.
- If you want to interact with all namespaces – for example, to list all Pods in your cluster you can pass the `--all-namespaces` flag.

### Four namespaces are defined when a cluster is created:
- **default:** this is where all the Kubernetes resources are created by default
- **kube-node-lease:** an administrative namespace where node lease information is stored – may be empty and/or non-existing
- **kube-public:** a namespace that is world-readable. Generic information can be stored here but it’s often empty. This namespace is mostly reserved for cluster usage
- **kube-system:** contains all infrastructure pods Or the namespace for objects created by the Kubernetes system

## Why do we need namespaces?
- Seperate different environments (dev, stg, prod, qa etc.)
- Avoid conflicts with an application with the same name (many teams are deploying applications with the same name)

Using multiple namespaces allows you to split complex systems with numerous components into smaller distinct groups. This is useful in scenarios where you want to split and limit resources across different resources. **Resource names only need to be unique within a namespace**. Two different namespaces can contain resources of the **same name**.

Although namespaces allow you to isolate objects into distinct groups, which allows you to operate only on those belonging to the specified namespace, they don’t provide any kind of isolation of running objects. For example, you may think that when different users deploy pods across different namespaces, those pods are isolated from each other and can’t communicate, but that’s not necessarily the case. Whether namespaces provide network isolation depends on which networking solution is deployed with Kubernetes. When the solution doesn’t provide inter-namespace network isolation, if a pod in namespace foo knows the IP address of a pod in namespace bar, there is nothing preventing it from sending traffic, such as HTTP requests, to the other pod.

## List available namespaces

```
kubectl get ns
OR
kubectl get namespace
``` 
```sh
[root@controller ~]# kubectl get ns
NAME              STATUS   AGE
default           Active   14d
kube-node-lease   Active   14d
kube-public       Active   14d
kube-system       Active   14d
```

### To get a list of all the available namespaces
```
kubectl get all --all-namespaces
```

### To list the pods from a specific namespace, for example to list all the pods under default namespace we will use following command:
```
kubectl get pods -n default
OR
kubectl get pods --namespace default
```

