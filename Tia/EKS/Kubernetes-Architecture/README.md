# Kubernetes Architecture

## Table of Contents	
1. Docker containers
    - What is a Container?
    - Why Containers
    - Why should we use containers or what was the problem without containers?
        - Solution 1 with Virtual Machine
        - Solution 2 Docker containers
    - Benefit of Containers

2. Virtual Machine vs Docker Containers

3. Container Orchestration
    - What is Container Orchestration?
    - Tools of Container Orchestration

4. Containers Registry
    - Elastic Container Registry (ECR)
        - What is Elastic Container Registry (ECR)
        - Benefits of Elastic Container Registry (ECR)
    - Docker Hub
        - What is a Docker Registry?
        - Why should you use Docker Hub?


5. Kubernetes Architecture
    - What is Kubernetes?
    - Kubernetes Cluster components

6. Kubernetes Cluster
    - What is a cluster
    - Master
    - Nodes (Minion)
    - Pods

7. Kubernetes Components
    - API Server
    - etcd key store
    - Scheduler
    - Controllers
    - Controller Runtime
    - kubelet
    - kube-proxy
    - Kube controller manager
    - Kubectl
    - Cloud Controller Manager

8. Conclusion


**Kubernetes also known as K8s** was created by Google based on their experience from containers in production. It is an open source project and one of the best and most popular container orchestration technology.

Before we understand Kubernetes, we must be familiar with **Docker containers** or else you if you are a beginner then you may find Kubernetes a little confusing to understand. So we will start first by understanding Dockers and Containers.

# 1. Docker containers

## What is a Container?
**A container** is a lightweight, stand-alone, executable package of a piece of software that includes everything needed to your application such as code, system libraries, system tools, runtime environment and settings.

## Why Containers
Instead of virtualizing the hardware stack as with the virtual machines approach, containers virtualize at the operating system level, with multiple containers running on top the **OS kernel** directly. This means that containers are far more **lightweight** because they share the OS kernel, start **much faster**, and use a fraction of the **memory** compared to booting an entire OS.
There are many container formats available. Docker is the most popular.

![](/images/k2.JPG)

## Why should we use containers or what was the problem without containers?
- In a normal IT work flow developers would develop a new application. Once the application development was completed, they would hand over that application over to the operations engineers, who were then supposed to install it on the production servers and get it running.
- If the operations engineers were lucky, they even got a somewhat accurate document with installation instructions from the developers. So far, so good, and life was easy.
- But things get a bit out of hand when, in an enterprise, there are many teams of developers that create quite different types of application, yet all of them need to be installed on the same production servers and kept running there.

![](/images/k1.JPG)

- Usually, each application has some external dependencies, such as which framework it was built on, what libraries it uses, and so on. Sometimes, two applications use the same framework but in different versions that might or might not be compatible with each other.
- So, installing a new version of a certain application can be a complex project on its own, and often needed months of planning and testing
- But these days we have to release a patch, update very often so this development and testing cycle can be very risky to the business.


### Solution 1 with Virtual Machine
The first solution was using **Virtual Machines**(VMs)
![](/images/k3.JPG)
- Instead of running multiple applications, all on the same server, companies would package and **run a single application on each VM**
- With this, all the compatibility problems were gone and life seemed to be good again.
- But this comes with it’s own set of demerits where each VM needs a lot of resources where most is used by underlying system OS.

### Solution 2 Docker containers
The ultimate solution to this problem was to provide something that is much more lightweight than VMs with is just **Docker container**
![](/images/k4.JPG)

- Instead of virtualizing hardware, containers run on top of single Linux instance.
- Don’t mistake Docker Engine as the equivalent of a hypervisor in more traditional VM, it is simply encapsulating process on the underlying system.
- With docker, developers would now package their application, dependent libraries, framework in a container and it can run everywhere that docker is installed.
- Operation teams can easily deploy the container without having to worry about configuring the application as these containers already contain an up and running application.

## Benefit of Containers
**Consistent Environment**
Containers give developers the ability to create predictable environments that are isolated from other applications. Containers can also include **software dependencies** needed by the application, such as specific versions of programming language runtimes and other software **libraries**. From the developer’s perspective, all this is guaranteed to be ***consistent*** no matter where the application is ultimately deployed. All this translates to productivity. Developers and IT Ops teams spend less time debugging and diagnosing differences in environments. Therefore, they more time available to develop and shipp new functionality for users. And it means fewer bugs since developers can now make assumptions everything will work well in **dev, test and production environments**.

**Run Anywhere**
Containers are able to run virtually anywhere, greatly easing development and deployment on Linux, Windows, and Mac operating systems, on virtual machines or bare metal, on a developer’s machine, in data centers, on-premises and of course in the public cloud. 

**Isolation**
Containers virtualize CPU, memory, storage, and network resources at the OS-level, providing developers with a sandboxed view of the OS logically isolated from other applications.


# 2. Virtual Machine vs Docker Containers
The image should be self explanatory to understand the difference between **Docker and VMware** architecture.

![](/images/k5.JPG)

- VM requires an **Hypervisor** which can be either installed on an operating system or directly on the hardware while a container can be deployed after installing docker.
- VM requires a **separating OS** to be installed to deploy your application while Docker containers share the **host operating system**, and that is why they are ***lightweight***
- Since Docker shares OS with host, the boot up time of docker container is **very less** while it is comparatively higher for VMs
- The docker containers share **Linux kernel** so it would be a good fit if you are planning to run multiple applications on the same Linux kernel but if you have applications that require different operating system then you will have to go for VM
- Since VM does not share the host OS it is comparatively more ***secure than Docker*** containers. An attacker may exploit all the containers if it gets access to the host or any single container.
- Since containers don’t have OS they use comparatively very **less resources** to execute the application and you can utilize the underlying resources more effectively

# 3. Container Orchestration
## What is Container Orchestration?

**Container orchestration** is a process that automates the deployment, management, scaling, networking, and availability of container-based applications. Also, it helps in monitoring the cluster and allow containers to communicate with one another.

Now that you are familiar with containers, next we need to learn about **container orchestration**. Just to summarise we have a docker container with certain applications running inside the container.

![](/images/k6.JPG)

- It is possible that your application from container 1 is dependent on some other application from another container such as database, message, logging service in the production environment.
- You may also need the ability to **scale up** the number of containers during peak time, for example I am sure you must be familiar with Amazon sale during holidays when they have a bunch of extra offers on all products. In such case they need to scale up their resources for applications to be able to handle more number of users. Once the festive offer is finished then they would again need to **scale down** the amount of containers with applications.
- To enable this functionality we need an underlying platform with a set of resources and capabilities. The platform needs to **orchestrate** the connectivity between the containers and automatically scale up or down based on the load.
- This while process of deploying and managing containers is known as **container orchestration**
- **Kubernetes is thus a container orchestration technology** used to orchestrate the deployment and management of hundreds and thousands of containers in a cluster environment.
- There are multiple similar technologies available today, docker has it’s own orchestration software i.e. Docker Swarm, Kubernetes from Google and Mesos from Apache.

![](/images/k7.JPG)

- Your application is now **highly available** as now we have multiple instances of your application across **multiple nodes**
- The user traffic is **load balanced** across various containers
- When demand increases, deploy more instances of the applications seamlessly and within a **matter of seconds** and we have the ability to do that at a service level when we run out of hardware resources then scale the number of underlying **nodes up and down** without taking down the application and this all can be done easily using a set of ***declarative object configuration file***.

## Tools of Container Orchestration
**What are some Container Orchestration tools available?**

**Kubernetes:** An orchestration system for Docker containers. It handles scheduling and manages workloads based on user-defined parameters.

**Amazon ECS:** ECS supports Docker containers and lets you run applications on a managed cluster of Amazon EC2 instances.

**Docker Swarm:** Provides native clustering functionality for Docker containers, which turns a group of Docker engines into a single, virtual Docker engine..

![](/images/k8.JPG)

**Azure Kubernetes Service (AKS):** It is a robust and cost-effective container orchestration service that helps you to deploy and manage containerized applications in seconds on Azure.

**Amazon Elastic Kubernetes Service (Amazon EKS)** gives you the flexibility to start, run, and scale Kubernetes applications in the AWS cloud.

**AWS Fargate** is a serverless compute engine for containers that works with both Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes Service (EKS)

**Amazon Elastic Container Service (Amazon ECS)** is a highly scalable, fast container management service that makes it easy to run, stop, and manage containers on a cluster

![](/images/k9.JPG)

# 4. Containers Registry
## Elastic Container Registry (ECR)

- **Elastic Container Registry (ECR)** is a fully-managed Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images. 
- ECR hosts our images in a highly available and scalable architecture, allowing us to reliably deploy containers for our applications. 
- Integration with AWS Identity and Access Management (IAM) provides resource-level control of each repository. 
- With Amazon ECR, there are no upfront fees or commitments. We pay only for the amount of data you store in your repositories and data transferred to the Internet.

## Benefits of Elastic Container Registry (ECR)
- Full managed
- Secure
- Highly Available
- Simplified Workflow

![](/images/k10.JPG)

## Docker Hub
**What is a Docker Registry?**

A Docker registry is a service that hosts and distributes Docker images. 

In many cases, a registry will consist of **multiple repositories** which contain images related to a specific project. Within a given repository tags are used to differentiate between versions of an image (e.g. ubuntu/httpd:version2.4, ubuntu/httpd:version2.5, ubuntu/httpd:version2.6 where “version2.x” is the tag). Users can pull (download) images they want to use or push (upload) images they want to store in a registry. 

**What is a Docker Hub?**

Docker Hub is Docker’s official cloud-based registry for Docker images.

**Why should you use Docker Hub?**

So, with all the different Docker registry options, why should you use Docker Hub? Here are a few of the key upsides of Docker Hub:

- **A large library of trusted images**- Docker Certified images, Verified Publisher images (which are Docker Certified and verified by the publisher), and Official Images published by Docker add a layer of trust for users. With millions — or in some cases billions — of downloads for many commonly used images, you can count on a reliable base image when you use Docker hub. While that’s great from the user perspective, it also benefits publishers as hosting an image in Docker Hub can give your project more exposure. 
- **A free tier- Currently,** Docker’s free plan offers unlimited public repositories and 1 private repository with up to 3 collaborators.
- **Built-in security features** All accounts can benefit from local image vulnerability scans. “Team” accounts also gain access to audit-logs and multifactor authentication (MFA) to further secure repositories. 
**Integrations & features that enable CI/CD–** Docker Hub also supports GitHub & Bitbucket integrations, automated tests, build triggers, and webhooks to help automate development pipelines and enable CI/CD (continuous integration/continuous delivery). 

# 5. Kubernetes Architecture
![](/images/k13.JPG)

## What is Kubernetes?
Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.

## Kubernetes Cluster components
- A **Kubernetes Cluster** consists of Master and Client node setup where we will have one Master or **Controller** node along with multiple Client nodes also referred as worker nodes or in minions.
- A **Master** is a node with Kubernetes installed and is responsible for the actual **orchestration** of containers on the worker nodes. It will contain all the information of cluster nodes, monitor each node and if a worker node fails then it will move the workload from the failed node to another worker node.

![](/images/k11.JPG)

- A **Node** is a worker machine which can be a physical or virtual machine on which Kubernetes is installed.
- Kubernetes does not deploy containers directly into the worker nodes, the containers are encapsulated into a Kubernetes object known as **Pods**.
- A **pod** is a single instance of an application and they are the smallest deployable units of computing that you can create and manage in Kubernetes.
- You will deploy containers inside these pods where you will deploy your application

Following is a basic architectural diagram of Kubernetes and the relationship between containers, pods, and physical worker nodes which were referred as **Minion** in past.

![](/images/k12.JPG)

# 6. Kubernetes Cluster
## What is kubernetes cluster?
- A Kubernetes cluster is a set of nodes that run containerized applications
- Kubernetes clusters are comprised of one master node and a number of worker nodes. 

## Kubernetes Cluster components
There are three main components in the Kubernetes Cluster i.e. **Nodes, Pods and Containers**. We have already learned about containers in depth so I will cover the remaining components here:

### Master
- Manage, plan, schedule, monitor nodes
- It manages the K8 cluster, storing the information regarding different, monitoring the node and container on them.
- The master is the control plane of Kubernetes.
- It consists of several components, such as an API server, a scheduler, and a controller manager.
- The master is responsible for the global state of the cluster, cluster-level scheduling of pods, and handling of events. Usually, all the master components are set up on a single host.
- When considering high-availability scenarios or very large clusters, you will want to have master redundancy.

### Nodes (Minion)
- You can think of these as container clients.
- A Pod always runs on a Node. A Node is a worker machine in Kubernetes and may be either a virtual or a physical machine, depending on the cluster
- Each Node is managed by the control plane
- A Node can have multiple pods, and the Kubernetes control plane automatically handles scheduling the pods across the Nodes in the cluster

**Every Kubernetes Node runs at least:**
- **Kubelet**, a process responsible for communication between the Kubernetes control plane and the Node; it manages the Pods and the containers running on a machine.
- **A container runtime** (like Docker) responsible for pulling the container image from a registry, unpacking the container, and running the application.

![](/images/k15.JPG)

### Pods
- A Pod is a group of one or more containers, with shared **storage/network resources**, and a specification for how to run the containers.
- We’re not implying that a pod always includes more than one container—it’s common for pods to contain only a **single container**.
- The key thing about pods is that when a pod does contain multiple containers, all of them are always run on a single worker node—it never spans multiple worker nodes
- These containers are guaranteed (by the cluster controller) to be located on the same host machine in order to facilitate sharing of resources
- It a wrap or a boundary or a the holder for containers in K8 cluster
- Container are running inside a pod
- The containers are encapsulated into K8 object none as pod.
- A pod is a single instance of an application. It is a smallest object that you can create in K8
- To scale up, you create pods. To scale down, you delete existing pods
- You do not add additional container in the pod to scale your application


![](/images/k14.JPG)


# 7. Kubernetes Components

When you are installing Kubernetes, basically you are working with following components:

![](/images/k16.JPG)

### API Server
- The API server acts as a frontend for Kubernetes
- The users, management devices, command line interfaces, all talk to API server to interact with Kubernetes cluster
- This is the primary management component of K8. it is responsible for managing all the communication in the cluster 
- The API server is at the center of all the difference tasks that need to be performed to make a change in the cluster
- This is the only K8 component that communicates directly with the etcd cluster
- It is responsible for orchestrating all communication within the cluster
- It is user by external users to perform management operation on the cluster using the **kubectl** command line tool
- The kube API server periodically feches status reports from the kubelet to monitor the status of nodes and containers on them.
- When we run the kubectl command, it goes to the API server, the API server authenticates the request, valide it and retrieves the data from the etcd cluster and responds back to the user with the request information.

![](/images/k17.JPG)

### etcd key store
- It is the K8 database that stores information in the key value format.
- It store information about the cluster (pods, nodes, configmap, roles, accounts and others)
- It stores all the masters and worker node information. 
- It stores all cluster data
- Kubernetes uses it to store the entire cluster state

### Kube scheduler
Kube-scheduler is responsible for scheduling pods into nodes. 

- It identify the right node to place the container on base on the container resources requirement, the worker node capacity
- It is responsible for deciding which pod runs on which node. It doesn’t actually place the pod on the node. That is the job of the kubelet. 
- The scheduler will decide which pod goes where and the kubelet will create the pod.
- In k8, the scheduler decides on which node the pod will be placed on depending on certain caracteria. You may have pods with certain resource requirements. 
- This is a very complicated task as it needs to consider multiple interacting factors, such as the following:
    - Resource requirements
    - Service requirements
    - Hardware/software policy constraints
    - Node affinity and anti-affinity specifications
    - Pod affinity and anti-affinity specifications
    - Taints and tolerations
    - Node selectors
    - Node draining

### Controller Runtime
- The public container runtime here is Docker
- We need a docker install on the worker nodes including the master node or and an equivalent of any container runtime.
- It is the underlying software that is used to run containers. In our case we will be using Docker as the underlying container but there are other options as well such as:
    - Docker, 
    - container-d, 
    - a rkt (roker containers) 
    - etc.

### kubelet
It is the agent that runs on each nodes in the cluster. The agent is responsible for making sure that the containers are running on the nodes as expected. That includes the following:
- Receiving pod specs
- Downloading pod secrets from the API server
- Mounting volumes
- Running the pod’s containers (via the configured runtime)
- Reporting the status of the node and each pod

### kube-proxy
- Manage networking communication so that containers can communicate in the cluster from one node to another node.
- It enable communication between services within the cluster
- Kube-proxy does low-level network housekeeping on each node
- Containers run on the server nodes, but they interact with each other as they are running in a unified networking setup.
- kube-proxy makes it possible for containers to communicate, although they are running on different nodes.

### Controllers
- The controllers are the brain behind Orchestration.
- They are responsible for noticing and responding when Nodes, containers or end points goes down
- The controller makes decision to bring up new containers in such case

### Kubectl
This is the K8 command line interface that we use to communicate with the API server.

### Cloud Controller Manager
- The cloud controller manager lets you link your cluster into your cloud provider's API, and separates out the components that interact with that cloud platform from components that only interact with your cluster.
- It only runs controllers that are specific to your cloud provider (AWS, Google, Azure). 
- On-Premise Kubernetes clusters will not have this component. 
- **Node controller:** For checking the cloud provider to determine if a node has been deleted in the cloud after it stops responding.
- **Service controller:** For creating, updating and deleting cloud provider load balancer

### Kube controller manager
- It is a process that continuously monitors the stage of various components within the system and works toward bringing the system to the desired functioning stage.
- Controllers are responsible for noticing and responding when nodes, containers or endpoints go down. They make decisions to bring up new containers in such cases. 
- **The node controller** is responsible for monitoring the status of he nodes and taking necessary action when nodes go down. 
- **Replication Controller** is responsible for monitoring the status of replica sets and ensuring that the desired number of pods are available at all times. If a pod dies, it creates another one.
- These are just 2 examples of controllers in K8. We have many controllers. There are all package under the kubernetes **controller manager**.
- When you install the kubernetes controller manager, other controllers get installed as well.

![](/images/k18.JPG)

# 8. Conclusion

In this Kubernetes session, we learned how applications have changed in recent years and how they can now be harder to deploy and manage. You’ve learned that:

- Linux containers provide much the same benefits as virtual machines, but are far more lightweight and allow for much better hardware utilization.
- Docker improved on existing Linux container technologies by allowing easier and faster provisioning of containerized apps together with their OS environments.
- Kubernetes exposes the whole datacenter as a single computational resource for running applications.
- Developers can deploy apps through Kubernetes without assistance from sysadmins.
- Sysadmins can sleep better by **having Kubernetes deal with failed nodes automatically**.