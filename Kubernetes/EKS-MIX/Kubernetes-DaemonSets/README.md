# Kubernetes DaemonSets

## Table of Contents	
1. Overview on Kubernetes DaemonSets
2. When to use – DaemonSet and/or ReplicaSet?
3. Using a DaemonSet to run a pod on every node
    - 3.1 Create DaemonSet
    - 3.2 Inspect DaemonSets
4. Limiting DaemonSets to Specific Nodes
    - 4.1 Create DaemonSet using Node Selectors
    - 4.2 Inspect DaemonSet
    - 4.3 Adding required labels to the node
    - 4.5 Removing the required label from the node
5. Deleting DaemonSets

## 1. Overview on Kubernetes DaemonSets
- A Kubernetes **DaemonSet** ensures a copy of a Pod is running across a set of nodes in a Kubernetes cluster.
- When you launch a new node in the cluster, a DaemonSet pod will be created
- DaemonSets are used to deploy system daemons such as log **collectors and monitoring agents**, which typically must run on every node.
- DaemonSets share similar functionality with ReplicaSets; both create Pods in the cluster.
- DaemonSets run only a single pod replica on each node, whereas ReplicaSets scatter them around the whole cluster randomly.

- A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.
- Some typical uses of a DaemonSet are:
    - running a cluster storage daemon on every node
    - running a logs collection daemon on every node
    - running a node monitoring daemon on every node

![](/images/DaemonSets1.JPG)

## 2. When to use – DaemonSet and/or ReplicaSet?
- ReplicaSets should be used when your application is completely decoupled from the node and you can run multiple copies on a given node without special consideration.
- DaemonSets should be used when a single copy of your application must run on all or a subset of the nodes in the cluster.

## 3. Using a DaemonSet to run a pod on every node
A DaemonSet deploys pods to all nodes in the cluster, unless you specify that the pods should only run on a subset of all the nodes. This is done by specifying the **node-Selector** property in the pod template, which is part of the DaemonSet definition (similar to the pod template in a ReplicaSet or ReplicationController).

## 3.1. Create DaemonSet
In this section we will setup a **logging agent using fluentd**. This agent is supposed to run on all the worker nodes part of Kubernetes cluster. Before we start we would need the KIND and apiVersion value for DaemonSet. This will be used in the manifest file.
```sh
root@ubuntu:~# kubectl explain DaemonSet | head -n 2
KIND:     DaemonSet
VERSION:  apps/v1
```
**Now that we have KIND and apiVersion, let me create the YAML file required for our DaemonSet:**
```
vim fluentd-daemonset.yml
```

```yml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
  labels:
    app: fluentd
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      containers:
      - name: fluentd
        image: fluent/fluentd:v0.14.10
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
          readOnly: true
      terminationGracePeriodSeconds: 30
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers
```

Once you have a valid DaemonSet configuration in place, you can use the `kubectl create` command to submit the DaemonSet to the Kubernetes API. 
```
kubectl create -f fluentd-daemonset.yml -n test
```

## 3.2. Inspect DaemonSets
To list the available daemonsets we will use `kubectl get` command. Here ds is short abbreviation of DaemonSets. Since I have a two node cluster, 2 daemonsets were created.
```sh
root@ubuntu:~# kgn
NAME                       STATUS   ROLES    AGE   VERSION
my-cluster-control-plane   Ready    master   65m   v1.19.1
my-cluster-worker          Ready    <none>   65m   v1.19.1
my-cluster-worker2         Ready    <none>   65m   v1.19.1
root@ubuntu:~# kubectl get ds
NAME      DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd   2         2         2       2            2           <none>          9m21s 
```

As expected we have two new **fluentd** pods created where the containers are getting created. We can add -o wide to the above command to make sure both the pods are started on different worker nodes:

```sh
root@ubuntu:~# kubectl get pods -o wide
NAME            READY   STATUS    RESTARTS   AGE   IP           NODE                
fluentd-cxpgf   1/1     Running   0          10m   10.244.1.8   my-cluster-worker2     
fluentd-wlmkx   1/1     Running   0          10m   10.244.2.4   my-cluster-worker
```      

## 4. Limiting DaemonSets to Specific Nodes
The most common use case for DaemonSets is to run a **Pod across every node in a Kubernetes cluster**. However, there are some cases where you want to deploy a Pod to only a subset of nodes. For example, maybe you have a workload that requires a GPU or access to fast storage only available on a subset of nodes in your cluster. In cases like these, **node labels** can be used to tag specific nodes that meet workload requirements.

## 4.1. Create DaemonSet using Node Selectors
**Node selectors** can be used to limit what nodes a Pod can run on in a given Kubernetes cluster. Node selectors are defined as part of the Pod spec when creating a **DaemonSet**. The DaemonSet configuration in following YAMl file limits NGINX to running only on nodes with the `ssd=true` label set.
```
vim nginx-daemonset.yml
```
```yaml
apiVersion: apps/v1
kind: "DaemonSet"
metadata:
  labels:
    app: nginx
    ssd: "true"
  name: nginx-fast-storage
spec:
  selector:
    matchLabels:
      ssd: "true"
  template:
    metadata:
      labels:
        app: nginx
        ssd: "true"
    spec:
      nodeSelector:
        ssd: "true"
      containers:
        - name: nginx
          image: nginx:1.10.0
```

We are defining a **DaemonSet** that will run a pod with a single container based on the nginx container image. An instance of this pod will be created for each node that has the `ssd: true` label.

Let’s create our nginx daemon set:
```
kubectl create -f nginx-daemonset.yml
```

## 4.2. Inspect DaemonSet
List the available daemon sets:
```sh
root@ubuntu:~# kubectl create -f nginx-daemonset.yml
daemonset.apps/nginx-fast-storage created
root@ubuntu:~# k get ds
NAME                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd              2         2         2       2            2           <none>          29m
nginx-fast-storage   0         0         0       0            0           ssd=true        8s
```
So the `nginx-fast-storage` DaemonSet has `0` DESIRED nodes, this would mean that currently there are no active cluster nodes with `ssd: true` label. You can list the nodes and their labels using:
```sh
root@ubuntu:~# kubectl get nodes --show-labels
NAME                       STATUS   ROLES    AGE    VERSION   LABELS
my-cluster-control-plane   Ready    master   109m   v1.19.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=my-cluster-control-plane,kubernetes.io/os=linux,node-role.kubernetes.io/master=
my-cluster-worker          Ready    <none>   109m   v1.19.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=my-cluster-worker,kubernetes.io/os=linux
my-cluster-worker2         Ready    <none>   109m   v1.19.1   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=my-cluster-worker2,kubernetes.io/os=linux
```

## 4.3. Adding required labels to the node
Let us go ahead and add this label to one of our worker nodes:
```sh
root@ubuntu:~# kgn
NAME                       STATUS   ROLES    AGE    VERSION
my-cluster-control-plane   Ready    master   113m   v1.19.1
my-cluster-worker          Ready    <none>   112m   v1.19.1
my-cluster-worker2         Ready    <none>   112m   v1.19.1
root@ubuntu:~# kubectl label nodes my-cluster-worker ssd=true
node/my-cluster-worker labeled
```

Now that one of our worker node is labelled with `ssd: true`, let’s re-validate the status of DaemonSets:
```sh
root@ubuntu:~# kubectl get ds
NAME                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd              2         2         2       2            2           <none>          62m
nginx-fast-storage   1         1         1       1            1           ssd=true        33m
```

As expected, now we have one DESIRED node where the label has matched, this would mean that now one Pod would be created on `my-cluster-worker` node
```sh
root@ubuntu:~# kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE                 NOMINATED NODE   READINESS GATES
fluentd-cxpgf              1/1     Running   0          58m   10.244.1.8   my-cluster-worker2   
fluentd-wlmkx              1/1     Running   0          58m   10.244.2.4   my-cluster-worker    
nginx-fast-storage-fz867   1/1     Running   0          86s   10.244.2.5   my-cluster-worker    
```

## 4.5. Removing the required label from the node
Now, imagine you’ve made a mistake and have mislabeled one of the nodes. It has a spinning disk drive, not an SSD. What happens if you change the node’s label?

**To remove a label from the node we use following syntax:**
```sh
kubectl label node <nodename> <labelname>-
kubectl label node my-cluster-worker ssd-
```

```sh
root@ubuntu:~# kubectl label node my-cluster-worker ssd-
node/my-cluster-worker labeled
```

As soon as we remove the label, we can see that the Pod status is **Terminating**:
```sh
root@ubuntu:~# kubectl get pods -o wide
NAME                            READY   STATUS        RESTARTS   AGE     IP          NODE                   NOMINATED NODE   READINESS GATES
fluentd-c9vcf                   1/1     Running       0          73m     10.44.0.3   my-cluster-worker2
fluentd-s2lrj                   1/1     Running       0          73m     10.36.0.4   my-cluster-worker 
nginx-fast-storage-4wmgc        0/1     Terminating   0          65m     <none>      my-cluster-worker 
```
So this is one good thing with **DaemonSets**. You don’t have to worry about manually deleting the pods in such scenarios. This wraps up our exploration of DaemonSets, so you may want to delete the DaemonSets which we created in this article. If you still have any other daemon pods running, you’ll see that deleting the DaemonSet deletes those pods as well.

## 5. Deleting DaemonSets
```sh
root@ubuntu:~# kubectl get ds
NAME                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
fluentd              2         2         2       2            2           <none>          72m
nginx-fast-storage   0         0         0       0            0           ssd=true        44m
root@ubuntu:~# kubectl delete ds fluentd nginx-fast-storage
daemonset.apps "fluentd" deleted
daemonset.apps "nginx-fast-storage" deleted
root@ubuntu:~# kubectl get ds
No resources found in test namespace.
```

## 6. Conclusion
DaemonSets provide an easy-to-use abstraction for running a set of **Pods on every node** in a Kubernetes cluster, or, if the case requires it, on a subset of nodes based on labels. The DaemonSet provides its own controller and scheduler to ensure key services like **monitoring agents** are always up and running on the right nodes in your cluster.
