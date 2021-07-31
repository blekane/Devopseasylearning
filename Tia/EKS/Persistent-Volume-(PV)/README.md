# Configure Pod storage with Kubernetes Persistent Volume (PV)

Table of Contents	
How Kubernetes Persistent Volume and Persistent Volume Claim works
1. Create Persistent Volume
    1.1 Capacity
    1.2 Volume Mode
    1.3 Access Modes
    1.4 Reclaim Policy
    1.5 Volume Type
    1.6 Mount Options
    1.7 Listing PersistentVolume
2. Claiming a PersistentVolume by creating a PersistentVolumeClaim
    2.1 Creating a PersistentVolumeClaim
    2.2 Listing PersistentVolumeClaims
3. Using a PersistentVolumeClaim in a pod
4. Recycling Persistent Volumes
5. Local Persistent Volumes with StorageClass
    5.1 Create StorageClass
    5.2 Creating a local persistent volume
    5.3 Making Persistent Volume Claims
    5.4 Create a Pod
Conclusion

With **Kubernetes Persistent Volumes** when a developer needs a certain amount of persistent storage for their application, they can request it from Kubernetes, the same way they can request CPU, memory, and other resources when creating a pod.

## How Kubernetes Persistent Volume and Persistent Volume Claim works
To enable apps to request storage in a Kubernetes cluster without having to deal with infrastructure specifics, two new resources were introduced. They are **Persistent-Volumes** and **PersistentVolumeClaims**

![](/images/pv1.JPG)

Let us understand in a step by step instruction how a Persistent Volume can be configured and used: