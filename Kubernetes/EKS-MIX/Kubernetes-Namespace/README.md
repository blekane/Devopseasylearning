# Kubernetes Namespace

## Table of Contents	
- Understanding Kubernetes Namespaces
- Why do we need namespaces?
- List available namespaces
- Creating a namespace
  - Using YAML file
  - Using kubectl command
  - Get details of namespace
- Create resource objects in other namespaces
  - Method-1: Using YAML file
  - Method-2: Using kubectl command
- Terminating namespaces
  - Deleting a Pod using name
  - Deleting pods by deleting the whole namespace
  - Deleting all pods in a namespace, while keeping the namespace
  - Delete all resources in a namespace
- Conclusion


You may have heard about Linux namespace which are used to isolate system processes from each other. In a similar concept we have namespace in Kubernetes which can provide a scope for objects names. We will learn more about Kubernetes namespace in this session.

## Understanding Kubernetes Namespaces
- Kubernetes uses namespaces to organize objects in the cluster.
- `It a kubernetes API object that is use to devide a cluster into multiple zone to help manage application`.
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

## Creating a namespace
A namespace is a Kubernetes resource like any other, so you can create it by posting a YAML file to the Kubernetes API server or directly via kubectl command.

1. Using kubectl command
```
kubectl create ns dev
kubectl create namespace dev
```
2. Using a manifest file
```
vim app-ns.yml
```
```yml
apiVersion: v1
kind: Namespace
metadata:
   name: qa
```
Create the namespace
```
kubectl create -f app-ns.yml
```

```sh
root@ubuntu:~# kubectl get namespace
NAME                 STATUS   AGE
default              Active   8d
dev                  Active   6m4s
kube-node-lease      Active   8d
kube-public          Active   8d
kube-system          Active   8d
local-path-storage   Active   8d
qa                   Active   87s
```

## Create resource objects in other namespaces

**Method-1: Using YAML file**

In this example I will create a new Pod with `nginx` container and explicitly define the namespace as `dev` in the YAML file itself under `metadata`:
```
vim nginx-dev.yml
```
```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-dev
  namespace: dev
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```
```sh
root@ubuntu:~# kubectl create -f nginx-dev.yml -n dev
root@ubuntu:~# kubectl get pods -n dev nginx-dev
NAME        READY   STATUS    RESTARTS   AGE
nginx-dev   1/1     Running   0          92s
```

**Method-2: Using kubectl command**

We can also pass an input argument to the kubectl command as `-n <namespace-name>` to assign a namespace. Here I have a different YAML file:
```
vim nginx-qa.yml
```
```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-qa
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```
We will create this Pod inside `qa` namespace:
```
kubectl create -f nginx-qa.yml -n qa
```
```sh
root@ubuntu:~# kubectl create -f nginx-qa.yml -n qa
pod/nginx-qa created
root@ubuntu:~# kubectl get pods -n qa
NAME       READY   STATUS    RESTARTS   AGE
nginx-qa   1/1     Running   0          22s
```

## It is possible to overwrite the namespace through the CLI?
```
vim nginx-dev.yml
```
```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-dev
  namespace: dev
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```
Let overwrite the `dev` namespace set in the manifest file with `qa` and see what will happen:
```
kubectl create -f nginx-dev.yml -n qa
```
```sh
root@ubuntu:~# kubectl create -f nginx-dev.yml -n qa
error: the namespace from the provided object "dev" does not match the namespace "qa". You must pass '--namespace=dev' to perform this operation.
```
This means we cannot overwrite the default namespace that was set on the manifest file through `kubectl`

## Deleting a Pod using name from a namespace
```sh
root@ubuntu:~# kubectl get po -n dev
NAME        READY   STATUS    RESTARTS   AGE
nginx-app   1/1     Running   0          27m
root@ubuntu:~# kubectl delete po nginx-app -n dev
pod "nginx-app" deleted
```

## Deleting pods by deleting the whole namespace
By default when we delete a namespace then all the pods under the provided namespace would also be terminated:
```sh
root@ubuntu:~# kubectl get po -n dev
NAME        READY   STATUS    RESTARTS   AGE
nginx-app   1/1     Running   0          17s
root@ubuntu:~# kubectl delete ns dev
namespace "dev" deleted
root@ubuntu:~# kubectl delete ns dev
Error from server (NotFound): namespaces "dev" not found
```

## Deleting all pods in a namespace, while keeping the namespace
Let delete all the pods inside `qa` namespace: `kubectl delete pods -n qa --all`. Since we had a single pod so only that one is deleted.
```sh
root@ubuntu:~# kubectl get po -n qa
NAME       READY   STATUS    RESTARTS   AGE
nginx-qa   1/1     Running   0          24m
root@ubuntu:~# kubectl delete pods -n qa --all
pod "nginx-qa" deleted
root@ubuntu:~# kubectl get po -n qa
No resources found in qa namespace.
```
## Delete all resources in a namespace
You can delete the Replicas and the pods, as well as all the Services you’ve created, by deleting all resources in the current namespace with a single command. To demonstrate this command I have created some of the resource objects in `qa` namespace:
```
kubectl delete all --all -n qa
```
```
[root@controller ~]# kubectl delete all --all -n qa
pod "myapp-replicaset-5hwhc" deleted
pod "myapp-replicaset-hmqj9" deleted
pod "myapp-replicaset-q6m5r" deleted
pod "nginx-deploy-58f9bf94f7-fztpl" deleted
pod "nginx-deploy-58f9bf94f7-qnjhq" deleted
service "nginx-deploy" deleted
deployment.apps "nginx-deploy" deleted
replicaset.apps "myapp-replicaset" deleted
replicaset.apps "nginx-deploy-58f9bf94f7" deleted
```
The first `all` in the command specifies that you’re deleting resources of all types, and the `--all` option specifies that you’re deleting all resource instances instead of specifying them by name.

## Conclusion
In this Kubernetes session we learned all about namespace and how it can be used to allow different teams to use the same cluster as though they were using separate Kubernetes clusters. 