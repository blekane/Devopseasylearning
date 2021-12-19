### Kube config file

```
cp ~/.kube/config  ~/.kube/dcp_nonprod

Sure, so by default ~/.kube/config is where the context will be stored
The file is refering to ~/.kube/dcp_nonprod
you can copy ~/.kube/config  to ~/.kube/dcp_nonprod
or export KUBEFILE=“config” in line4 of the script

Append $HOME/.kube/config to your KUBECONFIG environment variable
If you have a $HOME/.kube/config file, and it's not already listed in your KUBECONFIG environment variable, append it to your KUBECONFIG environment variable now. For example
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config
```

Config file example
```yml
apiVersion: v1
clusters:
- cluster:
    certificate-authority: fake-ca-file
    server: https://1.2.3.4
  name: development
contexts:
- context:
    cluster: development
    namespace: frontend
    user: developer
  name: dev-frontend
current-context: dev-frontend
kind: Config
preferences: {}
users:
- name: developer
  user:
    client-certificate: fake-cert-file
    client-key: fake-key-file
```

### grab our EKS config
```
aws eks update-kubeconfig --name eks_dev-Cluster --region us-east-1
cat .kube/config
-------------------------------------------------------------------

How to export the cluster .kube/config file?

1- Login in AWS using the CLI first with your secret and access key

2- Run the below command to export the .kube/config file in your home directory

aws eks update-kubeconfig --name [cluster_name] --region [region]
Example: aws eks update-kubeconfig --name devops-catalog --region us-east-2
```

```yaml
apiVersion: v1
        preferences: {}
        kind: Config

        clusters:
        - cluster:
            server: https://25639978B1C771EC053212A03218DD6E.gr7.us-east-1.eks.amazonaws.com
            certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeE1USXdNekUzTURnd09Gb1hEVE14TVRJd01URTNNRGd3T0Zvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT2h3CjNraGFVSk5YNjVnQmxnK1ZkS1dtUjdnSEcwL2Yrby83Zm5YT3lmMmh2SVk1dW1yd09aOTNVQng4RjlyZWhkd2oKRmYxTXErWnhqaXF3WW5uc1NkNmJOOEI2MjVYMzhzcStaZWFubUtRQ2p4S0ZMSnZYeS9KL1JFYlBCbEN1TWZGSApYWFVpK0hwTCttb0ZYQTRpZzZiU1d5WHd0NTZweEsrQU1yb0NUUFltSTMzSmV2WVVXd1RkVi9pUnVLOVZ5QktvCjBUSE81U3BLQVlhMktURC8vWVVxNDFvWDdoSmFJbDJMSiswY0RIeFdJY3NWY1p3M3hzYlRjTjMyRTJCaVZzOTQKZm5ldVJ5Y2hmVVZWaUVhSldSUUk3QXhkSGxDS05lSlpGRThTZkJsQ1VqRitCVm9wS3Z2REJsd05ZR1BHZDNqTAppenZvOG5CRDlNS0xFalRMOUpjQ0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZCVkIwYnBvNldNUUxGbEFMTGJBbGd4cmlMZHdNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFESU1iTVpGOVo3TC9VK3FybHBpbHFoS3U5bzc1TTJ4ckN4bVdUSlhObmpISTVhcGMvawpWaHh0bXlvZWpZUkNJSzllM09pZDFjQ1UvSVJaTlBGVisxRkt4bDZ2Rkt3SmQ3N090aTRtaXBUU1lWWFd3NTY4CmdpRmJnMDFtWmxBUXR1Uk90MXp0d3h2WTdKVHl5Y0dkbkYwM2Y0L2NtQ1ZlNzd4UFRNaW5EUnJiMzdCdTBISHQKL1FaRERGcldOVDQ4eTRjV3N3VFlQV0doKzhHWE9BTjV5c0U5Uk9INVdid1RxZ1R5QVlhR1RnWTN2WlpGUFFFNgo0cFZZRmRENlgzdDlvZ2tTN1lUUDM3dVlKQnlObzduSTF5MUZhL0xGNW5yRUl4TUI4WkYyeTFRK3MvbnpEMk5QClRqbzhQVnBUcFVxUys0Wmo3L0NCdk9BN0t6ZnNFa2x4eDkregotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
          name: eks_dev-Cluster

        contexts:
        - context:
            cluster: eks_dev-Cluster
            user: eks_dev-Cluster
          name: eks_dev-Cluster

        current-context: eks_dev-Cluster

        users:
        - name: eks_dev-Cluster
          user:
            exec:
              apiVersion: client.authentication.k8s.io/v1alpha1
              command: aws-iam-authenticator
              args:
                - "token"
                - "-i"
                - "dev-Cluster"
```